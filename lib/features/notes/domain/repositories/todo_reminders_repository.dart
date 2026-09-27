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

  /// All unchecked todos, including standalone items.
  Future<List<TodoItemModel>> getAllOpenTodos();

  /// Every todo, including completed and standalone items.
  Future<List<TodoItemModel>> getAllTodos();

  /// Updates a standalone todo. Note-backed todos must be changed in the note
  /// body so the note and todo index remain consistent.
  Future<void> setStandaloneTodoChecked(String id, bool isChecked);

  /// Creates a todo that is not attached to a note.
  Future<void> createStandaloneTodo(String text, {DateTime? reminderAt});

  /// Updates a standalone todo and keeps its reminder notification in sync.
  Future<void> updateStandaloneTodo(
    TodoItemModel todo, {
    required String text,
    required DateTime? reminderAt,
  });
}
