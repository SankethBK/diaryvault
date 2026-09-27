import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/dashboard_tile.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/features/notes/data/models/todo_item_model.dart';
import 'package:dairy_app/features/notes/domain/repositories/todo_reminders_repository.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/todos_overview_page.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// First dashboard pane, shown above the existing notes feed.
class TodayDashboardPane extends StatelessWidget {
  const TodayDashboardPane({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final locale = Localizations.localeOf(context).toString();

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  S.of(context).dashboardToday,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: homeTheme.previewTitleColor,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat.yMMMMd(locale).format(DateTime.now()),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: homeTheme.dateColor,
                  ),
                ),
              ],
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 10.0;
              final tileWidth = (constraints.maxWidth - gap) / 2;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  SizedBox(
                    width: tileWidth,
                    height: 100,
                    child: DashboardTile(
                      icon: Icons.edit_note_rounded,
                      label: S.of(context).dashboardQuickCapture,
                      color: theme.colorScheme.primary,
                      onTap: () => Navigator.of(context)
                          .pushNamed(NoteCreatePage.routeThroughHome),
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    height: 100,
                    child: _TodosDashboardTile(
                      onTap: () async {
                        await Navigator.of(context)
                            .pushNamed(TodosOverviewPage.route);
                      },
                    ),
                  ),
                  SizedBox(
                    width: tileWidth,
                    height: 100,
                    child: const _DailyPromptTile(),
                  ),
                  SizedBox(
                    width: tileWidth,
                    height: 100,
                    child: DashboardTile(
                      icon: Icons.mood_rounded,
                      label: S.of(context).dashboardMoodCheckIn,
                      subtitle: S.of(context).dashboardMoodSubtitle,
                      color: theme.colorScheme.primary,
                      onTap: () => _openMoodCheckIn(context),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DailyPromptTile extends StatelessWidget {
  const _DailyPromptTile();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DashboardTile(
      icon: Icons.lightbulb_outline_rounded,
      label: S.of(context).dashboardDailyPrompt,
      subtitle: S.of(context).dashboardPromptSubtitle,
      color: theme.colorScheme.primary,
      onTap: () => _openDailyPrompt(context),
    );
  }
}

Future<void> _openDailyPrompt(BuildContext context) async {
  final prompt = await showCustomDialog(
    context: context,
    child: const _DailyPromptDialog(),
  );
  if (!context.mounted || prompt is! String) return;
  await Navigator.of(context).pushNamed(
    NoteCreatePage.routeThroughHome,
    arguments: {
      'initialTitle': prompt,
      'initialBody': '',
    },
  );
}

Future<void> _openMoodCheckIn(BuildContext context) async {
  final draft = await showCustomDialog(
    context: context,
    child: const _MoodCheckInDialog(),
  );
  if (!context.mounted || draft is! _MoodCheckInDraft) return;
  final strings = S.of(context);
  final reflection = draft.reflection.trim();
  final body = StringBuffer(draft.openingSentence);
  if (reflection.isNotEmpty) {
    body
      ..write('\n\n')
      ..write(reflection);
  }
  await Navigator.of(context).pushNamed(
    NoteCreatePage.routeThroughHome,
    arguments: {
      'initialTitle': strings.dashboardMoodNoteTitle,
      'initialBody': body.toString(),
    },
  );
}

class _DailyPromptDialog extends StatefulWidget {
  const _DailyPromptDialog();

  @override
  State<_DailyPromptDialog> createState() => _DailyPromptDialogState();
}

class _DailyPromptDialogState extends State<_DailyPromptDialog> {
  late final List<String> _prompts;
  late int _selectedIndex;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_promptsInitialized) return;
    final strings = S.of(context);
    _prompts = [
      strings.dashboardDailyPrompt1,
      strings.dashboardDailyPrompt2,
      strings.dashboardDailyPrompt3,
      strings.dashboardDailyPrompt4,
      strings.dashboardDailyPrompt5,
      strings.dashboardDailyPrompt6,
      strings.dashboardDailyPrompt7,
      strings.dashboardDailyPrompt8,
    ];
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year)).inDays;
    _selectedIndex = dayOfYear % _prompts.length;
    _promptsInitialized = true;
  }

  bool _promptsInitialized = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final popupTheme = theme.extension<PopupThemeExtensions>()!;
    final strings = S.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.dashboardDailyPrompt,
              style: theme.textTheme.titleLarge?.copyWith(
                color: popupTheme.mainTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Text(
                _prompts[_selectedIndex],
                key: ValueKey(_selectedIndex),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: popupTheme.mainTextColor,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                onPressed: () => setState(() {
                  _selectedIndex = (_selectedIndex + 1) % _prompts.length;
                }),
                icon: const Icon(Icons.refresh_rounded),
                label: Text(strings.dashboardAnotherPrompt),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton.icon(
                onPressed: () => Navigator.of(context)
                    .pop(_prompts[_selectedIndex]),
                icon: const Icon(Icons.edit_note_rounded),
                label: Text(strings.dashboardWriteAboutPrompt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodCheckInDraft {
  const _MoodCheckInDraft(this.openingSentence, this.reflection);

  final String openingSentence;
  final String reflection;
}

class _MoodCheckInDialog extends StatefulWidget {
  const _MoodCheckInDialog();

  @override
  State<_MoodCheckInDialog> createState() => _MoodCheckInDialogState();
}

class _MoodCheckInDialogState extends State<_MoodCheckInDialog> {
  final TextEditingController _reflectionController = TextEditingController();
  int? _selectedMoodIndex;

  @override
  void dispose() {
    _reflectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final popupTheme = theme.extension<PopupThemeExtensions>()!;
    final strings = S.of(context);
    final moods = [
      (
        strings.dashboardMoodGreat,
        Icons.sentiment_very_satisfied_rounded,
        strings.dashboardMoodOpeningGreat,
      ),
      (
        strings.dashboardMoodGood,
        Icons.sentiment_satisfied_alt_rounded,
        strings.dashboardMoodOpeningGood,
      ),
      (
        strings.dashboardMoodOkay,
        Icons.sentiment_neutral_rounded,
        strings.dashboardMoodOpeningOkay,
      ),
      (
        strings.dashboardMoodLow,
        Icons.sentiment_dissatisfied_rounded,
        strings.dashboardMoodOpeningLow,
      ),
      (
        strings.dashboardMoodDifficult,
        Icons.sentiment_very_dissatisfied_rounded,
        strings.dashboardMoodOpeningDifficult,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.dashboardMoodSubtitle,
              style: theme.textTheme.titleLarge?.copyWith(
                color: popupTheme.mainTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 8,
              children: [
                for (var index = 0; index < moods.length; index++)
                  ChoiceChip(
                    selected: _selectedMoodIndex == index,
                    onSelected: (_) => setState(() => _selectedMoodIndex = index),
                    selectedColor: theme.colorScheme.primary,
                    labelStyle: TextStyle(
                      color: _selectedMoodIndex == index
                          ? theme.colorScheme.onPrimary
                          : popupTheme.mainTextColor,
                    ),
                    avatar: Icon(
                      moods[index].$2,
                      size: 19,
                      color: _selectedMoodIndex == index
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.primary,
                    ),
                    label: Text(moods[index].$1),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              strings.dashboardMoodContextPrompt,
              style: theme.textTheme.titleSmall?.copyWith(
                color: popupTheme.mainTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reflectionController,
              minLines: 2,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: popupTheme.mainTextColor),
              decoration: InputDecoration(
                hintText: strings.dashboardMoodReflectionHint,
                hintStyle: TextStyle(
                  color: popupTheme.mainTextColor.withValues(alpha: 0.65),
                ),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: theme.colorScheme.secondary,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton(
                onPressed: _selectedMoodIndex == null
                    ? null
                    : () => Navigator.of(context).pop(
                          _MoodCheckInDraft(
                            moods[_selectedMoodIndex!].$3,
                            _reflectionController.text,
                          ),
                        ),
                child: Text(strings.dashboardMoodSaveToJournal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodosDashboardTile extends StatefulWidget {
  const _TodosDashboardTile({required this.onTap});

  final Future<void> Function() onTap;

  @override
  State<_TodosDashboardTile> createState() => _TodosDashboardTileState();
}

class _TodosDashboardTileState extends State<_TodosDashboardTile> {
  late Future<List<TodoItemModel>> _todosFuture;

  @override
  void initState() {
    super.initState();
    _todosFuture = sl<ITodoRemindersRepository>().getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    return FutureBuilder<List<TodoItemModel>>(
      future: _todosFuture,
      builder: (context, snapshot) {
        final todos = snapshot.data ?? const <TodoItemModel>[];
        final openCount = todos.where((todo) => !todo.isChecked).length;
        final completedCount = todos.length - openCount;
        return DashboardTile(
          icon: Icons.checklist_rounded,
          label: S.of(context).dashboardTodos,
          subtitle: snapshot.hasError
              ? null
              : '${S.of(context).dashboardOpenTodos} $openCount  ·  '
                  '${S.of(context).dashboardCompletedTodos} $completedCount',
          color: theme.colorScheme.primary,
          onTap: () async {
            await widget.onTap();
            if (!mounted) return;
            setState(() {
              _todosFuture = sl<ITodoRemindersRepository>().getAllTodos();
            });
          },
          titleColor: homeTheme.previewTitleColor,
          subtitleColor: homeTheme.previewBodyColor,
        );
      },
    );
  }
}
