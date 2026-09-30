import 'dart:convert';

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/features/notes/core/utils/todo_delta_parser.dart';
import 'package:dairy_app/features/notes/data/repositories/todo_reminders_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/notifications_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/todo_reminders_repository.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:uuid/uuid.dart';

final log = printer("TodoReminderActions");

/// Editor-side glue for todo reminders: inserting/updating/removing the
/// reminder embed of a todo line and keeping notifications in sync.
class TodoReminderActions {
  TodoReminderActions._();

  /// Sets a one-shot reminder on the todo line containing [offset].
  static Future<void> setReminderAtOffset(
      BuildContext context, QuillController controller, int offset) async {
    final notesBloc = context.read<NotesBloc>();
    await _setReminderOnLine(context, controller, notesBloc, offset);
  }

  /// Tap on an existing reminder chip: offers to change the time or remove
  /// the reminder entirely.
  static Future<void> onReminderChipTapped(
      BuildContext context, QuillController controller, Embed node) async {
    final notesBloc = context.read<NotesBloc>();

    final data = _decodeReminderData(node);
    if (data == null) return;
    final reminderId = data["id"] as String;
    final reminderTime =
        DateTime.fromMillisecondsSinceEpoch(data["time"] as int);

    final action = await showCustomDialog(
      context: context,
      child: SizedBox(
        width: 290,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.alarm),
              label: Text(S.current.changeReminderTime),
              onPressed: () => Navigator.pop(context, "change"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.alarm_off),
              label: Text(S.current.removeReminder),
              onPressed: () => Navigator.pop(context, "remove"),
            ),
          ],
        ),
      ),
    );

    if (action == "remove") {
      controller.replaceText(node.documentOffset, 1, '',
          TextSelection.collapsed(offset: node.documentOffset));
      await sl<INotificationsRepository>()
          .cancelNotification(notificationIdForReminder(reminderId));
      await _syncTodos(controller, notesBloc.state);
      showToast(S.current.reminderRemoved);
      return;
    }

    if (action == "change") {
      await _setReminderOnLine(
          context, controller, notesBloc, node.documentOffset,
          existingReminderId: reminderId,
          existingReminderTime: reminderTime);
    }
  }

  static Future<void> _setReminderOnLine(BuildContext context,
      QuillController controller, NotesBloc notesBloc, int offset,
      {String? existingReminderId, DateTime? existingReminderTime}) async {
    final state = notesBloc.state;
    if (state.isEncrypted) {
      showToast(S.current.todoRemindersUnavailableInEncryptedNotes);
      return;
    }

    final line = _todoLineAt(controller, offset);
    if (line == null) {
      showToast(S.current.todoRemindersNeedUncheckedTodo);
      return;
    }

    final picked = await _pickDateTime(
      context,
      initialDateTime: existingReminderTime,
    );
    if (picked == null) return;
    if (!picked.isAfter(DateTime.now())) {
      showToast(S.current.reminderTimeMustBeInFuture);
      return;
    }

    final notificationsRepository = sl<INotificationsRepository>();
    var allowed = await notificationsRepository.areNotificationsEnabled();
    if (!allowed) {
      allowed = await notificationsRepository.requestPermission();
    }
    if (!allowed) return;

    final reminderId = existingReminderId ?? const Uuid().v4();
    final reminderAt = picked.millisecondsSinceEpoch;
    final todoText = _todoText(line);

    // Schedule before changing the document. If the platform rejects the
    // alarm, retain the previous chip/reminder and tell the user it failed.
    try {
      await notificationsRepository.scheduleOneTimeNotification(
        id: notificationIdForReminder(reminderId),
        title: S.current.todoReminderNotificationTitle,
        body: todoText,
        dateTime: picked,
      );
    } catch (e, stackTrace) {
      log.e("failed to schedule todo reminder: $e\n$stackTrace");
      showToast(S.current.reminderSchedulingFailed);
      return;
    }

    // Remove old embeds after scheduling. Preserve this reminder's ID so
    // changing its time doesn't cancel the newly scheduled alarm.
    await _removeReminderEmbeds(
      controller,
      line,
      preserveReminderId: reminderId,
    );

    // The document changed during deletions; query the line again.
    final freshLine = _todoLineAt(controller, offset) ?? line;

    final embed = BlockEmbed.custom(CustomBlockEmbed(
        kTodoReminderEmbedType,
        encodeTodoReminderData(id: reminderId, time: reminderAt)));
    // The timestamp is a preview, so keep it after the todo text. The
    // separate action clock is removed once this embed is present.
    final insertAt = freshLine.documentOffset + freshLine.length - 1;
    controller.replaceText(
        insertAt, 0, embed, TextSelection.collapsed(offset: insertAt));

    // Removing the action before inserting the reminder can briefly make the
    // todo look unreminded to the editor listener, which may restore its
    // action clock. Clean up any such marker now that the date embed exists.
    final lineWithReminder = _todoLineAt(controller, freshLine.documentOffset);
    if (lineWithReminder != null) {
      _removeReminderActionEmbeds(controller, lineWithReminder);
    }

    await _syncTodos(controller, notesBloc.state);
    showToast(S.current.reminderSet);
  }

  /// Returns the todo (unchecked check-list) line containing [offset],
  /// or null when [offset] is not on one.
  static Line? _todoLineAt(QuillController controller, int offset) {
    final query = controller.document.queryChild(offset);
    if (query.node is! Line) return null;
    final line = query.node as Line;
    if (line.style.attributes[Attribute.list.key] != Attribute.unchecked) {
      return null;
    }
    return line;
  }

  /// Plain text of the todo without embed characters / trailing newline
  static String _todoText(Line line) {
    return line
        .toPlainText()
        .replaceAll(Embed.kObjectReplacementCharacter, '')
        .replaceAll('\n', '')
        .trim();
  }

  /// Deletes every todo reminder embed on [line] and cancels the
  /// notification that belongs to it.
  static Future<void> _removeReminderEmbeds(
      QuillController controller, Line line,
      {required String preserveReminderId}) async {
    final offsets = <int>[];

    for (final child in line.children) {
      if (child is Embed && child.value.type == BlockEmbed.customType) {
        try {
          final custom = CustomBlockEmbed.fromJsonString(child.value.data);
          final data = _decodeReminderData(child);
          if (custom.type == kTodoReminderActionEmbedType) {
            offsets.add(child.documentOffset);
          } else if (data != null) {
            final existingId = data["id"] as String;
            if (existingId != preserveReminderId) {
              await sl<INotificationsRepository>()
                  .cancelNotification(notificationIdForReminder(existingId));
            }
            offsets.add(child.documentOffset);
          }
        } catch (e) {
          log.w("skipping malformed custom embed: $e");
        }
      } else if (child is Embed && child.value.type == kTodoReminderEmbedType) {
        final data = _decodeReminderData(child);
        if (data != null) {
          final existingId = data["id"] as String;
          if (existingId != preserveReminderId) {
            await sl<INotificationsRepository>()
                .cancelNotification(notificationIdForReminder(existingId));
          }
          offsets.add(child.documentOffset);
        }
      } else if (child is Embed &&
          child.value.type == kTodoReminderActionEmbedType) {
        offsets.add(child.documentOffset);
      }
    }

    // delete from the end so earlier offsets stay valid
    for (final offset in offsets.reversed) {
      controller.replaceText(
          offset, 1, '', TextSelection.collapsed(offset: offset));
    }
  }

  static void _removeReminderActionEmbeds(
      QuillController controller, Line line) {
    final offsets = <int>[];
    for (final child in line.children) {
      if (child is! Embed) continue;
      if (child.value.type == kTodoReminderActionEmbedType) {
        offsets.add(child.documentOffset);
      } else if (child.value.type == BlockEmbed.customType) {
        try {
          final custom = CustomBlockEmbed.fromJsonString(child.value.data);
          if (custom.type == kTodoReminderActionEmbedType) {
            offsets.add(child.documentOffset);
          }
        } catch (_) {}
      }
    }
    for (final offset in offsets.reversed) {
      controller.replaceText(
          offset, 1, '', TextSelection.collapsed(offset: offset));
    }
  }

  static Map<String, dynamic>? _decodeReminderData(Embed node) {
    if (node.value.type == kTodoReminderEmbedType) {
      return decodeTodoReminderData(node.value.data as String);
    }

    final custom = CustomBlockEmbed.fromJsonString(node.value.data as String);
    if (custom.type != kTodoReminderEmbedType) return null;
    return decodeTodoReminderData(custom.data as String);
  }

  /// Immediately refreshes the todos table; the periodic autosave will do
  /// it again, this is here so completion/deletion cancels feel instant.
  static Future<void> _syncTodos(
      QuillController controller, NotesState state) async {
    if (!state.safe) return;
    try {
      await sl<ITodoRemindersRepository>().syncTodosForNote(
        noteId: state.id,
        noteTitle: state.title ?? "",
        body: jsonEncode(controller.document.toDelta().toJson()),
        isEncrypted: state.isEncrypted,
      );
    } catch (e) {
      log.w("todo sync skipped: $e");
    }
  }

  static Future<DateTime?> _pickDateTime(
    BuildContext context, {
    DateTime? initialDateTime,
  }) async {
    final now = DateTime.now();
    final initialDate = initialDateTime != null &&
            initialDateTime.isAfter(now)
        ? initialDateTime
        : now;

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 2)),
    );
    if (date == null || !context.mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        initialDateTime ?? now.add(const Duration(hours: 1)),
      ),
    );
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
