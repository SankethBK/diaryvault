import 'package:dairy_app/features/notes/data/models/todo_item_model.dart';

/// Tracks the todo items of every note in a dedicated table and keeps the
/// one-shot reminder notifications attached to them in sync.
abstract class ITodoRemindersRepository {
  /// Re-evaluates the todos of one note from its quill [body]:
  /// schedules new reminders, cancels reminders of completed/removed todos
  /// and refreshes the todos table.
  ///
  /// Also used as a "quick" sync by callers that already hold the
  /// in-memory delta.
  Future<void> syncTodosForNote({
    required String noteId,
    required String noteTitle,
    required String body,
    required bool isEncrypted,
  });

  /// Cancels all reminder notifications and drops all todo rows of the
  /// given notes (used when notes are deleted or encrypted)
  Future<void> purgeRemindersForNotes(List<String> noteIds);

  /// All unchecked todos across notes (for the upcoming dashboard widget)
  Future<List<TodoItemModel>> getAllOpenTodos();
}
