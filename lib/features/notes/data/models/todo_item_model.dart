import 'package:dairy_app/core/databases/db_schemas.dart';

/// A single todo (check-list) line extracted from a note's quill body.
/// Optionally carries a one-shot reminder.
class TodoItemModel {
  final String id;
  final String noteId;
  final String noteTitle;
  final String text;
  final bool isChecked;

  /// epoch millis of the scheduled reminder, null when unset
  final int? reminderAt;

  /// id of the scheduled system notification for this reminder
  final int? notificationId;

  const TodoItemModel({
    required this.id,
    required this.noteId,
    required this.noteTitle,
    required this.text,
    required this.isChecked,
    this.reminderAt,
    this.notificationId,
  });

  bool get hasReminder => reminderAt != null;

  Map<String, dynamic> toMap() => {
        Todos.ID: id,
        Todos.NOTE_ID: noteId,
        Todos.NOTE_TITLE: noteTitle,
        Todos.TEXT: text,
        Todos.IS_CHECKED: isChecked ? 1 : 0,
        Todos.REMINDER_AT: reminderAt,
        Todos.NOTIFICATION_ID: notificationId,
      };

  factory TodoItemModel.fromMap(Map<String, dynamic> map) => TodoItemModel(
        id: map[Todos.ID] as String,
        noteId: map[Todos.NOTE_ID] as String,
        noteTitle: map[Todos.NOTE_TITLE] as String? ?? "",
        text: map[Todos.TEXT] as String? ?? "",
        isChecked: (map[Todos.IS_CHECKED] as int?) == 1,
        reminderAt: map[Todos.REMINDER_AT] as int?,
        notificationId: map[Todos.NOTIFICATION_ID] as int?,
      );
}
