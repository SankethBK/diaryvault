import 'dart:convert';

import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/background_image.dart';
import 'package:dairy_app/core/widgets/glass_app_bar.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/notes/core/utils/todo_delta_parser.dart';
import 'package:dairy_app/features/notes/data/models/todo_item_model.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/todo_reminders_repository.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:intl/intl.dart';

class TodosOverviewPage extends StatefulWidget {
  static const String route = '/todos';

  const TodosOverviewPage({super.key});

  @override
  State<TodosOverviewPage> createState() => _TodosOverviewPageState();
}

class _TodosOverviewPageState extends State<TodosOverviewPage> {
  late Future<List<TodoItemModel>> _todosFuture;
  final Set<String> _updatingTodoIds = {};

  @override
  void initState() {
    super.initState();
    _todosFuture = sl<ITodoRemindersRepository>().getAllTodos();
  }

  Future<void> _setTodoChecked(TodoItemModel todo, bool isChecked) async {
    setState(() => _updatingTodoIds.add(todo.id));
    try {
      if (todo.noteId == null) {
        await sl<ITodoRemindersRepository>()
            .setStandaloneTodoChecked(todo.id, isChecked);
      } else {
        await _setNoteTodoChecked(todo, isChecked);
      }
      if (!mounted) return;
      setState(() {
        _updatingTodoIds.remove(todo.id);
        _todosFuture = sl<ITodoRemindersRepository>().getAllTodos();
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _updatingTodoIds.remove(todo.id));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).dashboardTodoUpdateFailed)),
      );
    }
  }

  Future<void> _showTodoEditor({TodoItemModel? todo}) async {
    final strings = S.of(context);
    final draft = await showCustomDialog(
      context: context,
      child: _AddStandaloneTodoDialog(todo: todo),
    );
    if (!mounted || draft is! _StandaloneTodoDraft) return;

    try {
      final repository = sl<ITodoRemindersRepository>();
      if (todo == null) {
        await repository.createStandaloneTodo(
          draft.text,
          reminderAt: draft.reminderAt,
        );
      } else {
        await repository.updateStandaloneTodo(
          todo,
          text: draft.text,
          reminderAt: draft.reminderAt,
        );
      }
      if (!mounted) return;
      setState(() {
        _todosFuture = sl<ITodoRemindersRepository>().getAllTodos();
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(draft.reminderAt == null
              ? strings.dashboardTodoUpdateFailed
              : strings.reminderSchedulingFailed),
        ),
      );
    }
  }

  Future<void> _setNoteTodoChecked(TodoItemModel todo, bool isChecked) async {
    final notesRepository = sl<INotesRepository>();
    final note = await notesRepository.getNote(todo.noteId!);
    final noteModel = note.fold(
      (failure) => throw StateError(failure.toString()),
      (value) => value,
    );
    final parsedTodos = parseTodosFromDeltaJson(noteModel.body);
    var todoIndex = parsedTodos.indexWhere(
      (parsedTodo) =>
          parsedTodo.reminderId != null && parsedTodo.reminderId == todo.id,
    );
    if (todoIndex < 0) {
      todoIndex = parsedTodos.indexWhere(
        (parsedTodo) =>
            todo.id == '${noteModel.id}-${parsedTodos.indexOf(parsedTodo)}',
      );
    }
    if (todoIndex < 0) throw StateError('Todo no longer exists in its note');

    final document = Document.fromJson(jsonDecode(noteModel.body));
    final todoLines = <Line>[];
    for (final block in document.root.children) {
      if (block is! Block) continue;
      for (final child in block.children) {
        if (child is! Line) continue;
        final listStyle = child.style.attributes[Attribute.list.key];
        if (listStyle != Attribute.checked &&
            listStyle != Attribute.unchecked) {
          continue;
        }
        final text = child
            .toPlainText()
            .replaceAll(Embed.kObjectReplacementCharacter, '')
            .replaceAll('\n', '')
            .trim();
        if (text.isNotEmpty) todoLines.add(child);
      }
    }
    if (todoIndex >= todoLines.length) {
      throw StateError('Todo no longer exists in its note');
    }

    final controller = QuillController(
      document: document,
      selection: const TextSelection.collapsed(offset: 0),
    );
    final line = todoLines[todoIndex];
    // flutter_quill 0.3.x exposes formatText rather than formatLine. List
    // attributes belong to the line-ending newline, so format that character.
    controller.formatText(
      line.documentOffset + line.length - 1,
      1,
      isChecked ? Attribute.checked : Attribute.unchecked,
    );

    final updatedNote = noteModel.toJson()
      ..['body'] = jsonEncode(controller.document.toDelta().toJson())
      ..['plain_text'] = controller.document.toPlainText()
      // NotesRepository.updateNote expects NoteAsset objects here; toJson()
      // converts them to maps for serialization, which its local data source
      // does not accept.
      ..['asset_dependencies'] = noteModel.assetDependencies
      ..['last_modified'] = DateTime.now().millisecondsSinceEpoch;
    controller.dispose();

    final result = await notesRepository.updateNote(updatedNote);
    result.fold(
      (failure) => throw StateError(failure.toString()),
      (_) {},
    );

    if (sl<UserConfigCubit>()
            .state.userConfigModel?.isAutoSyncEnabled ==
        true) {
      sl<NoteSyncCubit>().startNoteSync();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final authTheme = Theme.of(context).extension<AuthPageThemeExtensions>()!;
    final homeTheme = Theme.of(context).extension<HomePageThemeExtensions>()!;
    final topPadding = MediaQuery.of(context).padding.top +
        AppBar().preferredSize.height +
        8;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: Text(strings.dashboardTodos),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoEditor(),
        tooltip: strings.dashboardAddTodo,
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: getBackgroundDecoration(
          authTheme.backgroundImage,
          backgroundColor: authTheme.backgroundColor,
        ),
        padding: EdgeInsets.only(top: topPadding, left: 8, right: 8),
        child: GlassMorphismCover(
          sigmaX: homeTheme.sigmaX,
          sigmaY: homeTheme.sigmaY,
          borderRadius: BorderRadius.zero,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: homeTheme.borderColor),
              gradient: LinearGradient(
                colors: [
                  homeTheme.backgroundGradientStartColor,
                  homeTheme.backgroundGradientEndColor,
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
            child: FutureBuilder<List<TodoItemModel>>(
              future: _todosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text(strings.dashboardTodoLoadFailed));
                }

                final todos = snapshot.data ?? const <TodoItemModel>[];
                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                final tomorrow = today.add(const Duration(days: 1));
                final dueToday = <TodoItemModel>[];
                final overdue = <TodoItemModel>[];
                final upcoming = <TodoItemModel>[];
                final noDueDate = <TodoItemModel>[];
                final completed = <TodoItemModel>[];

                for (final todo in todos) {
                  if (todo.isChecked) {
                    completed.add(todo);
                  } else if (todo.reminderAt == null) {
                    noDueDate.add(todo);
                  } else {
                    final reminderDate = DateTime.fromMillisecondsSinceEpoch(
                      todo.reminderAt!,
                    );
                    if (reminderDate.isBefore(today)) {
                      overdue.add(todo);
                    } else if (reminderDate.isBefore(tomorrow)) {
                      dueToday.add(todo);
                    } else {
                      upcoming.add(todo);
                    }
                  }
                }
                dueToday.sort(
                  (a, b) => a.reminderAt!.compareTo(b.reminderAt!),
                );
                overdue.sort(
                  (a, b) => a.reminderAt!.compareTo(b.reminderAt!),
                );
                upcoming.sort(
                  (a, b) => a.reminderAt!.compareTo(b.reminderAt!),
                );

                if (todos.isEmpty) return _buildEmptyState(context);

                return ListView(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 96),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 12),
                      child: Text(
                        strings.dashboardTodoSourceHint,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: homeTheme.dateColor,
                            ),
                      ),
                    ),
                    _TodoSection(
                      title: strings.dashboardDueToday,
                      todos: dueToday,
                      updatingTodoIds: _updatingTodoIds,
                      onCheckedChanged: _setTodoChecked,
                      onEdit: (todo) => _showTodoEditor(todo: todo),
                    ),
                    _TodoSection(
                      title: strings.dashboardOverdue,
                      todos: overdue,
                      updatingTodoIds: _updatingTodoIds,
                      onCheckedChanged: _setTodoChecked,
                      onEdit: (todo) => _showTodoEditor(todo: todo),
                    ),
                    _TodoSection(
                      title: strings.dashboardUpcoming,
                      todos: upcoming,
                      updatingTodoIds: _updatingTodoIds,
                      onCheckedChanged: _setTodoChecked,
                      onEdit: (todo) => _showTodoEditor(todo: todo),
                    ),
                    _TodoSection(
                      title: strings.dashboardNoDueDate,
                      todos: noDueDate,
                      updatingTodoIds: _updatingTodoIds,
                      onCheckedChanged: _setTodoChecked,
                      onEdit: (todo) => _showTodoEditor(todo: todo),
                    ),
                    _TodoSection(
                      title: strings.dashboardCompletedTodos,
                      todos: completed,
                      updatingTodoIds: _updatingTodoIds,
                      onCheckedChanged: _setTodoChecked,
                      onEdit: (todo) => _showTodoEditor(todo: todo),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.checklist_rounded,
                size: 44, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            Text(S.of(context).dashboardNoTodos,
                style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(S.of(context).dashboardNoTodosSubtitle,
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              S.of(context).dashboardTodoSourceHint,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: homeTheme.dateColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StandaloneTodoDraft {
  const _StandaloneTodoDraft(this.text, this.reminderAt);

  final String text;
  final DateTime? reminderAt;
}

class _AddStandaloneTodoDialog extends StatefulWidget {
  const _AddStandaloneTodoDialog({this.todo});

  final TodoItemModel? todo;

  @override
  State<_AddStandaloneTodoDialog> createState() =>
      _AddStandaloneTodoDialogState();
}

class _AddStandaloneTodoDialogState extends State<_AddStandaloneTodoDialog> {
  late final TextEditingController _textController;
  DateTime? _reminderAt;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.todo?.text ?? '');
    final reminderAt = widget.todo?.reminderAt;
    _reminderAt = reminderAt == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(reminderAt);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _chooseReminder() async {
    final now = DateTime.now();
    final currentReminder = _reminderAt ?? now.add(const Duration(minutes: 30));
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(
        currentReminder.year,
        currentReminder.month,
        currentReminder.day,
      ),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null || !mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentReminder),
    );
    if (pickedTime == null || !mounted) return;

    setState(() {
      _reminderAt = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      _errorText = null;
    });
  }

  void _submit() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      setState(() => _errorText = S.of(context).dashboardTodoRequired);
      return;
    }
    final reminderWasUnchanged = widget.todo?.reminderAt ==
        _reminderAt?.millisecondsSinceEpoch;
    if (_reminderAt != null &&
        !_reminderAt!.isAfter(DateTime.now()) &&
        !reminderWasUnchanged) {
      setState(() => _errorText = S.of(context).reminderTimeMustBeInFuture);
      return;
    }
    Navigator.of(context).pop(_StandaloneTodoDraft(text, _reminderAt));
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final theme = Theme.of(context);
    final popupTheme = theme.extension<PopupThemeExtensions>()!;
    final locale = Localizations.localeOf(context).toString();
    final reminderLabel = _reminderAt == null
        ? strings.dashboardReminderOptional
        : DateFormat.yMMMd(locale).add_jm().format(_reminderAt!);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.todo == null
                  ? strings.dashboardAddTodo
                  : strings.dashboardEditTodo,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: popupTheme.mainTextColor,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _textController,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              cursorColor: theme.colorScheme.secondary,
              onSubmitted: (_) => _submit(),
              style: TextStyle(color: popupTheme.mainTextColor),
              decoration: InputDecoration(
                labelText: strings.dashboardTodoTitle,
                labelStyle: TextStyle(
                  color: popupTheme.mainTextColor.withValues(alpha: 0.8),
                ),
                floatingLabelStyle:
                    TextStyle(color: theme.colorScheme.secondary),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: popupTheme.mainTextColor.withValues(alpha: 0.55),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: popupTheme.mainTextColor.withValues(alpha: 0.55),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorScheme.secondary,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.alarm_add_outlined,
                color: theme.colorScheme.secondary,
              ),
              title: Text(
                strings.setTodoReminder,
                style: TextStyle(color: popupTheme.mainTextColor),
              ),
              subtitle: Text(
                reminderLabel,
                style: TextStyle(
                  color: popupTheme.mainTextColor.withValues(alpha: 0.75),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: strings.setTodoReminder,
                    onPressed: _chooseReminder,
                    icon: Icon(
                      Icons.edit_calendar_outlined,
                      color: popupTheme.mainTextColor,
                    ),
                  ),
                  if (_reminderAt != null)
                    IconButton(
                      tooltip: strings.removeReminder,
                      onPressed: () => setState(() => _reminderAt = null),
                      icon: Icon(Icons.close, color: popupTheme.mainTextColor),
                    ),
                ],
              ),
              onTap: _chooseReminder,
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 4),
              Text(
                _errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: popupTheme.mainTextColor,
                  ),
                  child: Text(strings.cancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  child: Text(widget.todo == null
                      ? strings.dashboardCreateTodo
                      : strings.dashboardSaveTodo),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TodoSection extends StatelessWidget {
  const _TodoSection({
    required this.title,
    required this.todos,
    required this.updatingTodoIds,
    required this.onCheckedChanged,
    required this.onEdit,
  });

  final String title;
  final List<TodoItemModel> todos;
  final Set<String> updatingTodoIds;
  final Future<void> Function(TodoItemModel, bool) onCheckedChanged;
  final ValueChanged<TodoItemModel> onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    return AnimatedSize(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.topCenter,
      child: todos.isEmpty
          ? const SizedBox(width: double.infinity, height: 0)
          : Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 9),
                    child: Row(
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: homeTheme.previewTitleColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${todos.length}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: homeTheme.dateColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: homeTheme.notePreviewBorderColor,
                      ),
                      gradient: LinearGradient(
                        colors: [
                          homeTheme.notePreviewUnselectedGradientStartColor,
                          homeTheme.notePreviewUnselectedGradientEndColor,
                        ],
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: Column(
                        key: ValueKey(todos.map((todo) => todo.id).join('|')),
                        children: [
                          for (var index = 0; index < todos.length; index++) ...[
                            _TodoRow(
                              todo: todos[index],
                              isUpdating:
                                  updatingTodoIds.contains(todos[index].id),
                              onCheckedChanged: (checked) =>
                                  onCheckedChanged(todos[index], checked),
                              onEdit: onEdit,
                            ),
                            if (index < todos.length - 1)
                              Divider(
                                height: 1,
                                indent: 58,
                                color: homeTheme.notePreviewBorderColor,
                              ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _TodoRow extends StatelessWidget {
  const _TodoRow({
    required this.todo,
    required this.isUpdating,
    required this.onCheckedChanged,
    required this.onEdit,
  });

  final TodoItemModel todo;
  final bool isUpdating;
  final ValueChanged<bool> onCheckedChanged;
  final ValueChanged<TodoItemModel> onEdit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final sourceTitle = todo.noteTitle.trim();
    final dateLabel = todo.reminderAt == null
        ? null
        : DateFormat.MMMd(Localizations.localeOf(context).toString())
            .add_jm()
            .format(DateTime.fromMillisecondsSinceEpoch(todo.reminderAt!));

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: isUpdating
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Checkbox(
              value: todo.isChecked,
              side: BorderSide(
                color: homeTheme.previewTitleColor,
                width: 1.5,
              ),
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return homeTheme.checkBoxSelectedColor;
                }
                return Colors.transparent;
              }),
              checkColor: ThemeData.estimateBrightnessForColor(
                        homeTheme.checkBoxSelectedColor,
                      ) ==
                      Brightness.dark
                  ? Colors.white
                  : Colors.black,
              onChanged: (value) {
                if (value != null) onCheckedChanged(value);
              },
            ),
      title: Text(
        todo.text,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: homeTheme.previewTitleColor,
          decoration: todo.isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: _TodoMetadata(
        sourceTitle: sourceTitle,
        dateLabel: dateLabel,
        noteId: todo.noteId,
      ),
      trailing: todo.noteId == null
          ? IconButton(
              tooltip: S.of(context).dashboardEditTodo,
              icon: Icon(Icons.edit_outlined, color: homeTheme.dateColor),
              onPressed: () => onEdit(todo),
            )
          : IconButton(
              tooltip: S.of(context).dashboardOpenInNote,
              icon: Icon(Icons.open_in_new, color: homeTheme.dateColor),
              onPressed: () => Navigator.of(context).pushNamed(
                NotesReadOnlyPage.routeThroughHome,
                arguments: todo.noteId,
              ),
            ),
    );
  }
}

class _TodoMetadata extends StatelessWidget {
  const _TodoMetadata({
    required this.sourceTitle,
    required this.dateLabel,
    required this.noteId,
  });

  final String sourceTitle;
  final String? dateLabel;
  final String? noteId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final labels = <String>[
      if (sourceTitle.isNotEmpty && noteId != null) sourceTitle,
      if (dateLabel != null) dateLabel!,
    ];
    if (labels.isEmpty) return const SizedBox.shrink();
    return Text(
      labels.join(' · '),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodySmall?.copyWith(color: homeTheme.dateColor),
    );
  }
}
