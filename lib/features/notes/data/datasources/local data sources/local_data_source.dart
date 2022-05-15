import 'dart:io';

import 'package:dairy_app/core/databases/db_schemas.dart';
import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/logger/logger.dart';

final log = printer("NotesLocalDataSource");

class NotesLocalDataSource implements INotesLocalDataSource {
  late Database database;

  NotesLocalDataSource() {
    DBProvider.instance.database.then((db) {
      database = db;
    });
  }

  @override
  Future<void> saveNote(NoteModel note) async {
    // Insert notes
    var res = await database.insert(Notes.TABLE_NAME, note.toJson());

    if (res == -1) {
      throw const DatabaseInsertionException("Note insertion failed");
    }

    log.i("note ${note.id} inserted into db");

    // insert notte dependecies
    for (var asset in note.assetDependencies) {
      res = await database.insert(
          NoteDependencies.TABLE_NAME, {"note_id": note.id, ...asset.toJson()});
      if (res == -1) {
        log.e("Insertion of ${asset.assetPath} faied");
        throw const DatabaseInsertionException();
      }
    }

    log.i("Note assets successfully saved id: ${note.id}");
  }

  @override
  Future<List<NotePreviewModel>> fetchNotesPreview() async {
    // Only columns required for notes preview
    List<Map<String, Object?>> result;
    try {
      result = await database.query(
        Notes.TABLE_NAME,
        columns: [Notes.ID, Notes.TITLE, Notes.PLAIN_TEXT, Notes.CREATED_AT],
      );
    } catch (e) {
      log.e("Local database query for fetching notes preview failed $e");
      throw const DatabaseQueryException();
    }

    return result.map((noteMap) => NotePreviewModel.fromJson(noteMap)).toList();
  }

  @override
  Future<List<NoteModel>> fetchNotes() async {
    // Only columns required for notes preview
    List<Map<String, dynamic>> result;
    try {
      result = await database.query(
        Notes.TABLE_NAME,
      );
    } catch (e) {
      log.e("Local database query for fetching notes failed $e");
      throw const DatabaseQueryException();
    }

    return result.map((noteMap) => NoteModel.fromJson(noteMap)).toList();
  }

  @override
  Future<void> deleteNote(String id) async {
    List<Map<String, Object?>> files;

    // First delete all files
    try {
      files = await database.query(
        NoteDependencies.TABLE_NAME,
        columns: [NoteDependencies.NOTE_ID, NoteDependencies.ASSET_PATH],
        where: "${NoteDependencies.NOTE_ID} = ?",
        whereArgs: [id],
      );
    } catch (e) {
      log.e("Querying of assets failed for note id: $id");
      throw const DatabaseQueryException();
    }

    try {
      for (var file in files) {
        await _deleteFile(file["asset_path"] as String);
      }
    } catch (e) {
      // not a criticial exception, so don't throw error
      log.e("file deletion failed for note id:$id $e");
    }

    // delete all records of assets

    var count = await database.delete(
      NoteDependencies.TABLE_NAME,
      where: "${NoteDependencies.NOTE_ID} = ?",
      whereArgs: [id],
    );

    // if number of deleted rows != number of assets present, throw exception
    if (count != files.length) {
      log.e("assets deletion unsuccessful for note id: $id");
      throw const DatabaseDeleteException();
    }

    // update table by setting all fields of note to null, except id, last modified
    // TODO: sending flutter datetime objectes to sql might be wrong, look into it
    count = await database.update(
        Notes.TABLE_NAME,
        {
          "title": null,
          "body": null,
          "plain_text": null,
          "created_at": null,
          "hash": null,
          "last_modified": DateTime.now().millisecondsSinceEpoch,
        },
        where: "${Notes.ID} = ?",
        whereArgs: [id]);

    if (count != 1) {
      log.e("notes deletion unsuccessful for note id: $id");
      throw const DatabaseDeleteException();
    }
    log.i("deletion successful for note id: $id");
  }

  @override
  Future<NoteModel> getNote(String id) async {
    var result = await database
        .query(Notes.TABLE_NAME, where: "${Notes.ID} = ?", whereArgs: [id]);
    if (result.isEmpty) {
      log.e("Notes with id: $id not found");
      throw const DatabaseQueryException();
    }
    log.i("get note successful, note id: $id");
    return NoteModel.fromJson(result[0]);
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    var count = await database.update(
        Notes.TABLE_NAME,
        {
          ...note.toJson(),
          "last_modified": DateTime.now().millisecondsSinceEpoch
        },
        where: "${Notes.ID} = ?",
        whereArgs: [note.id]);

    if (count != 1) {
      log.e("note updation failed for id: ${note.id}");
      throw const DatabaseUpdateException();
    }

    log.i("update note successful for id: ${note.id}");
  }

  Future<void> _deleteFile(String filePath) async {
    final file = File(filePath);
    await file.delete();
    log.i("file $filePath deleted successfully");
  }
}
