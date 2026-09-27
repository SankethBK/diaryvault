import 'package:dairy_app/core/databases/db_schemas.dart';
import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/features/notes/data/models/todo_item_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ITodosLocalDataSource {
  /// Replaces all todo rows of [noteId]
  Future<void> replaceForNote(String noteId, List<TodoItemModel> todos);

  Future<List<TodoItemModel>> getForNote(String noteId);

  /// Every todo row across all notes
  Future<List<TodoItemModel>> getAllTodos();

  Future<void> deleteForNotes(List<String> noteIds);
}

class TodosLocalDataSource implements ITodosLocalDataSource {
  static late Database database;

  TodosLocalDataSource._();

  static Future<TodosLocalDataSource> create() async {
    database = await DBProvider.instance.database;
    return TodosLocalDataSource._();
  }

  @override
  Future<void> replaceForNote(String noteId, List<TodoItemModel> todos) async {
    final batch = database.batch();

    batch.delete(Todos.TABLE_NAME,
        where: "${Todos.NOTE_ID} = ?", whereArgs: [noteId]);

    for (final todo in todos) {
      batch.insert(Todos.TABLE_NAME, todo.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<List<TodoItemModel>> getForNote(String noteId) async {
    final rows = await database.query(Todos.TABLE_NAME,
        where: "${Todos.NOTE_ID} = ?", whereArgs: [noteId]);
    return rows.map((row) => TodoItemModel.fromMap(row)).toList();
  }

  @override
  Future<List<TodoItemModel>> getAllTodos() async {
    final rows = await database.query(Todos.TABLE_NAME);
    return rows.map((row) => TodoItemModel.fromMap(row)).toList();
  }

  @override
  Future<void> deleteForNotes(List<String> noteIds) async {
    if (noteIds.isEmpty) return;
    final placeholders = List.filled(noteIds.length, "?").join(", ");
    await database.delete(Todos.TABLE_NAME,
        where: "${Todos.NOTE_ID} IN ($placeholders)", whereArgs: noteIds);
  }
}
