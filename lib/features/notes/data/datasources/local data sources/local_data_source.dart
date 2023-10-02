import 'dart:io';

import 'package:dairy_app/core/databases/db_schemas.dart';
import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../core/logger/logger.dart';

final log = printer("NotesLocalDataSource");

class NotesLocalDataSource implements INotesLocalDataSource {
  static late Database database;

  NotesLocalDataSource._();

  static create() async {
    database = await DBProvider.instance.database;
    return NotesLocalDataSource._();
  }

  @override
  Future<void> saveNote(Map<String, dynamic> noteMap) async {
    // extract asset dependecies and remove it from the map

    var assetDependencies = noteMap["asset_dependencies"];
    noteMap.remove("asset_dependencies");

    // Insert notes
    try {
      var res = await database.insert(Notes.TABLE_NAME, noteMap);

      if (res == -1) {
        log.e("database insertion for ${noteMap["id"]} unsuccessful");
        throw const DatabaseInsertionException("Note insertion failed");
      }
    } catch (e) {
      log.e(e);
      rethrow;
    }

    log.i("note ${noteMap["id"]} inserted into db");

    // insert note dependecies
    log.i("saving asset dependencies = $assetDependencies");

    for (NoteAssetModel asset in assetDependencies) {
      try {
        var res =
            await database.insert(NoteDependencies.TABLE_NAME, asset.toJson());
        if (res == -1) {
          log.e("Insertion of ${asset.assetPath}} faied");
          throw const DatabaseInsertionException();
        }
      } catch (e) {
        log.e(e);
        rethrow;
      }
    }

    log.i("Note assets successfully saved id: ${noteMap["id"]}");
  }

  @override
  Future<List<NotePreviewModel>> fetchNotesPreview(String authorId) async {
    // Only columns required for notes preview
    List<Map<String, Object?>> result;
    try {
      result = await database.query(Notes.TABLE_NAME,
          columns: [Notes.ID, Notes.TITLE, Notes.PLAIN_TEXT, Notes.CREATED_AT],
          where:
              "${Notes.DELETED} != 1 and ( ${Notes.AUTHOR_ID} = '$authorId' or ${Notes.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' )",
          orderBy: "${Notes.CREATED_AT} DESC");
    } catch (e) {
      log.e("Local database query for fetching notes preview failed $e");
      throw const DatabaseQueryException();
    }

    return result.map((noteMap) => NotePreviewModel.fromJson(noteMap)).toList();
  }

  @override
  Future<List<NoteModel>> fetchNotes(String authorId) async {
    List<Map<String, dynamic>> result;
    try {
      result = await database.query(
        Notes.TABLE_NAME,
        where:
            "${Notes.DELETED} != 1 and ( ${Notes.AUTHOR_ID} = '$authorId' or ${Notes.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' )",
      );
    } catch (e) {
      log.e("Local database query for fetching notes failed $e");
      throw const DatabaseQueryException();
    }

    return result.map((noteMap) => NoteModel.fromJson(noteMap)).toList();
  }

  @override
  Future<void> deleteNote(String id, String authorId,
      {bool hardDeletion = false}) async {
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
        await deleteFile(file["asset_path"] as String);
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

    // hard delete the note
    if (hardDeletion == true) {
      count = await database
          .delete(Notes.TABLE_NAME, where: "${Notes.ID} = ?", whereArgs: [id]);
      if (count != 1) {
        log.e("notes (hard) deletion unsuccessful for note id: $id");
        throw const DatabaseDeleteException();
      }

      log.i("notes (hard) deletion successful for note id: $id");
    } else {
      // update table by setting all fields of note to null, except id, last modified
      count = await database.update(
          Notes.TABLE_NAME,
          {
            "title": null,
            "body": null,
            "plain_text": null,
            "created_at": null,
            "hash": null,
            "last_modified": DateTime.now().millisecondsSinceEpoch,
            "deleted": 1,
          },
          where: "${Notes.ID} = ?",
          whereArgs: [id]);

      if (count != 1) {
        log.e("notes (soft) deletion unsuccessful for note id: $id");
        throw const DatabaseDeleteException();
      }

      log.i("notes (soft) deletion successful for note id: $id");
    }
  }

  @override
  Future<NoteModel> getNote(String id, String authorId) async {
    var result = await database
        .query(Notes.TABLE_NAME, where: "${Notes.ID} = ?", whereArgs: [id]);
    if (result.isEmpty) {
      log.e("Notes with id: $id not found");
      throw const DatabaseQueryException();
    }
    log.i("get note successful, note id: $id");

    // Get asset dependencies for that note

    var _assetDependencies = await database.query(NoteDependencies.TABLE_NAME,
        where: "${NoteDependencies.NOTE_ID} = ?", whereArgs: [id]);

    log.i("Retrieved asset depencies = $_assetDependencies");

    var finalNote = makeModifiableResults(result).map((note) {
      return {"asset_dependencies": _assetDependencies, ...note};
    }).toList()[0];

    return NoteModel.fromJson(finalNote);
  }

  @override
  Future<void> updateNote(Map<String, dynamic> noteMap, String authorId) async {
    // store id
    var id = noteMap["id"];
    noteMap.remove("id");

    // Remove all asset dependencies and insert all of them again

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

    // try {
    //   for (var file in files) {
    //     await deleteFile(file["asset_path"] as String);
    //   }
    // } catch (e) {
    //   // not a criticial exception, so don't throw error
    //   log.e("file deletion failed for note id:$id $e");
    // }

    // delete all records of assets

    var res = await database.delete(
      NoteDependencies.TABLE_NAME,
      where: "${NoteDependencies.NOTE_ID} = ?",
      whereArgs: [id],
    );

    // if number of deleted rows != number of assets present, throw exception
    if (res != files.length) {
      log.e("assets deletion unsuccessful for note id: $id");
      throw const DatabaseDeleteException();
    }

    // Insert the new ones

    log.i("saving asset dependencies = ${noteMap["asset_dependencies"]}");

    for (NoteAssetModel asset in noteMap["asset_dependencies"]) {
      try {
        var res =
            await database.insert(NoteDependencies.TABLE_NAME, asset.toJson());
        if (res == -1) {
          log.e("Insertion of ${asset.assetPath}} faied");
          throw const DatabaseInsertionException();
        }
      } catch (e) {
        log.e(e);
        rethrow;
      }
    }

    noteMap.remove("asset_dependencies");

    var count = await database.update(Notes.TABLE_NAME,
        {...noteMap, "last_modified": DateTime.now().millisecondsSinceEpoch},
        where: "${Notes.ID} = ?", whereArgs: [id]);

    if (count != 1) {
      log.e("note updation failed for id: $id");
      throw const DatabaseUpdateException();
    }

    log.i("update note successful for id: $id");
  }

  @override
  Future<void> deleteFile(String filePath) async {
    final file = File(filePath);
    await file.delete();
    log.i("file $filePath deleted successfully");
  }

  @override
  Future<List<String>> getAllNoteIds(String authorId) async {
    var result = await database.query(Notes.TABLE_NAME,
        columns: [Notes.ID],
        where:
            "${Notes.DELETED} != 1 and ( ${Notes.AUTHOR_ID} = '$authorId' or ${Notes.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' )",
        orderBy: "${Notes.CREATED_AT} DESC");

    return result.map((noteMap) => noteMap["id"] as String).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getNotesIndex(String authorId) async {
    var allNotesIndex = await database.query(Notes.TABLE_NAME,
        columns: [Notes.ID, Notes.LAST_MODIFIED, Notes.HASH, Notes.DELETED],
        where:
            "${Notes.AUTHOR_ID} = '$authorId' or ${Notes.AUTHOR_ID} = '${GuestUserDetails.guestUserId}'",
        orderBy: "${Notes.CREATED_AT} DESC");

    return makeModifiableResults(allNotesIndex).map((note) {
      return note;
    }).toList();
  }

  @override
  Future<List<NotePreviewModel>> searchNotes(String authorId,
      {String? searchText, DateTime? startDate, DateTime? endDate}) async {
    log.i("Searching for notes");
    List<Map<String, Object?>> result;

    try {
      String searchQuery = "";

      searchQuery +=
          "(${Notes.TITLE} LIKE '%${searchText ?? ''}%' OR ${Notes.PLAIN_TEXT} LIKE '%${searchText ?? ''}%')";

      if (startDate != null) {
        String startDateStr = startDate.millisecondsSinceEpoch.toString();

        searchQuery += " AND (${Notes.CREATED_AT} >= '$startDateStr')";
      }
      if (endDate != null) {
        String endDateStr = endDate.millisecondsSinceEpoch.toString();

        searchQuery += " AND (${Notes.CREATED_AT} <= '$endDateStr')";
      }

      result = await database.query(
        Notes.TABLE_NAME,
        columns: [Notes.ID, Notes.TITLE, Notes.PLAIN_TEXT, Notes.CREATED_AT],
        where:
            "${Notes.DELETED} != 1 AND $searchQuery and ( ${Notes.AUTHOR_ID} = '$authorId' or ${Notes.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' )",
        orderBy: "${Notes.CREATED_AT} DESC",
      );
    } catch (e) {
      log.e("Local database query for searching notes failed $e");
      throw const DatabaseQueryException();
    }

    return result.map((noteMap) => NotePreviewModel.fromJson(noteMap)).toList();
  }

  //* Utils

  /// Generate a modifiable result set
  List<Map<String, dynamic>> makeModifiableResults(
      List<Map<String, dynamic>> results) {
    // Generate modifiable
    return List<Map<String, dynamic>>.generate(
        results.length, (index) => Map<String, dynamic>.from(results[index]),
        growable: true);
  }
}
