import 'dart:io';

import 'package:dairy_app/core/databases/db_schemas.dart';
import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/smart_folders/data/datasources/local_data_sources/local_data_source_template.dart';
import 'package:dairy_app/features/smart_folders/data/models/smart_folders_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../../core/logger/logger.dart';
import '../../../../notes/data/datasources/local data sources/local_data_source.dart';
import '../../../../notes/data/models/notes_model.dart';

final log = printer("SmartFoldersLocalDataSource");

class SmartFoldersLocalDataSource implements ISmartFoldersLocalDataSource {
  static late Database database;

  SmartFoldersLocalDataSource._();

  static create() async {
    database = await DBProvider.instance.database;
    return SmartFoldersLocalDataSource._();
  }

  @override
  Future<void> saveSmartFolder(Map<String, dynamic> smartFolderMap) async {
    // Insert smart folder
    log.i("Starting to insert smart folder ${smartFolderMap["folder_id"]} into db");

    try {
      var res = await database.insert(SmartFolders.TABLE_NAME, smartFolderMap);

      if (res == -1) {
        log.e("database insertion for ${smartFolderMap["folder_id"]} unsuccessful");
        throw const DatabaseInsertionException("Smart folder insertion failed");
      }
    } catch (e) {
      log.e(e);
      rethrow;
    }

    log.i("Smart folder ${smartFolderMap["folder_id"]} inserted into db");
  }

  @override
  Future<List<SmartFolderModel>> fetchSmartFolders({required String authorId, List<String>? folderIds}) async {
    log.i("Starting to fetch smart folders of $authorId into db");
    List<Map<String, dynamic>> result;

    try {
      if (folderIds != null && folderIds.isNotEmpty) {
        // Format the folderIds list for the SQL query
        String folderIdsString = folderIds.map((id) => "'$id'").join(', ');

        result = await database.query(
          SmartFolders.TABLE_NAME,
          where:
          "( ${SmartFolders.AUTHOR_ID} = '$authorId' or ${SmartFolders.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' ) AND ${SmartFolders.FOLDER_ID} IN ($folderIdsString)",
        );
      } else {
        result = await database.query(
          SmartFolders.TABLE_NAME,
          where:
          "( ${SmartFolders.AUTHOR_ID} = '$authorId' or ${SmartFolders.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' )",
        );
      }
    } catch (e) {
      log.e("Local database query for fetching notes failed $e");
      throw const DatabaseQueryException();
    }

    log.i("Fetch smart folders of $authorId successful");
    return result.map((folderMap) => SmartFolderModel.fromJson(folderMap)).toList();
  }

  @override
  Future<SmartFolderModel> getSmartFolder(String id, String authorId) async {
    // TODO: use authorId or not?
    log.i("Starting get smart folders $id");

    var result = await database
        .query(SmartFolders.TABLE_NAME, where: "${SmartFolders.FOLDER_ID} = ?", whereArgs: [id]);
    if (result.isEmpty) {
      log.e("Smart folders with id: $id not found");
      throw const DatabaseQueryException();
    }
    log.i("get folder successful, folder id: $id");

    return SmartFolderModel.fromJson(result.first);
  }

  @override
  Future<void> updateSmartFolder(Map<String, dynamic> smartFolderMap, String authorId) async {
    // store id
    log.i("Starting update smart folder ${smartFolderMap["folder_id"]}");

    var id = smartFolderMap["folder_id"];
    smartFolderMap.remove("folder_id");

    // No "last_updated" column so no need to update it to now
    var count = await database.update(SmartFolders.TABLE_NAME,
        {...smartFolderMap},
        where: "${SmartFolders.FOLDER_ID} = ?", whereArgs: [id]);

    if (count != 1) {
      log.e("smart folder update failed for id: $id");
      throw const DatabaseUpdateException();
    }

    log.i("update smart folder successful for id: $id");
  }

  @override
  Future<void> deleteSmartFolder(String id, String authorId) async {
    // No difference between soft/hard deletion here
    log.i("Starting deletion of smart folder $id");

    var count = await database
        .delete(SmartFolders.TABLE_NAME, where: "${SmartFolders.FOLDER_ID} = ?", whereArgs: [id]);
    if (count != 1) {
      log.e("Smart folder deletion unsuccessful for folder id: $id");
      throw const DatabaseDeleteException();
    }

    log.i("Smart folder (hard) deletion successful for folder id: $id");
  }

  @override
  Future<List<String>> getAllSmartFolderIds(String authorId) async {
    log.i("Starting getAll smart folder for $authorId");

    var result = await database.query(SmartFolders.TABLE_NAME,
        columns: [SmartFolders.FOLDER_ID],
        where:
        "( ${SmartFolders.AUTHOR_ID} = '$authorId' or ${SmartFolders.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' )",
        orderBy: "${SmartFolders.CREATED_AT} DESC");

    log.i("getAll smart folder successful");
    return result.map((folderMap) => folderMap["folder_id"] as String).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getSmartFolderIndex(String authorId) async {
    var allNotesIndex = await database.query(SmartFolders.TABLE_NAME,
        where:
        "${SmartFolders.AUTHOR_ID} = '$authorId' or ${SmartFolders.AUTHOR_ID} = '${GuestUserDetails.guestUserId}'",
        orderBy: "${SmartFolders.CREATED_AT} DESC");

    return NotesLocalDataSource.makeModifiableResults(allNotesIndex).map((note) {
      return note;
    }).toList();
  }

  @override
  Future<List<SmartFolderModel>> searchSmartFolders(String authorId, {String? searchText, DateTime? startDate, DateTime? endDate, List<String>? tags}) async {
    log.i("Searching for smart folders");
    List<Map<String, Object?>> result;

    String searchQuery = "(${SmartFolders.FOLDER_NAME} LIKE '%${searchText ?? ''}%')";

    // Add start date requirement if it exists
    if (startDate != null) {
      String startDateStr = startDate.millisecondsSinceEpoch.toString();
      searchQuery += " AND (${SmartFolders.CREATED_AT} >= '$startDateStr')";
    }

    // Add end date requirement if it exists
    if (endDate != null) {
      String endDateStr = endDate.millisecondsSinceEpoch.toString();
      searchQuery += " AND (${SmartFolders.CREATED_AT} <= '$endDateStr')";
    }

    try {
      // Add tag requirement if it exists
      if (tags != null && tags.isNotEmpty) {
        // FolderID's with matching tags
        List<String> folderIds = [];

        for (String tagName in tags) {
          final tagResult = await database.query(
            SmartFolders.TABLE_NAME,
            columns: [SmartFolders.FOLDER_ID],
            where: "${SmartFolders.FOLDER_TAGS} LIKE ?",
            whereArgs: ["%" + tagName + "%"],
          );

          // Add folder ID to requirement if there is a match (ignore tag requirement if no match at all)
          for (var tagMap in tagResult) {
            if (tagMap[SmartFolders.FOLDER_ID] != null) {
              final folderID = tagMap[SmartFolders.FOLDER_ID] as String;
              folderIds.add("'$folderID'");
            }
          }
        }

        if (folderIds.isNotEmpty) {
          searchQuery += " AND ${SmartFolders.FOLDER_ID} IN (${folderIds.join(", ")})";
        }
      }

      log.i("searchQuery = $searchQuery");

      result = await database.query(
        SmartFolders.TABLE_NAME,
        where:
        "$searchQuery and ( ${SmartFolders.AUTHOR_ID} = '$authorId' or ${SmartFolders.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' )",
        orderBy: "${SmartFolders.CREATED_AT} DESC",
      );

    } catch (e) {
      log.e("Local database query for searching notes failed $e");
      throw const DatabaseQueryException();
    }

    log.i("Search for smart folders successful");
    return result.map((folderMap) => SmartFolderModel.fromJson(folderMap)).toList();
  }

  @override
  Future<List<NoteModel>> fetchSmartFolderContent(String id, String authorId) async {
    // Returns all notes that contain at least one matching tag
    log.i("Fetching the content of smart folder $id");
    SmartFolderModel smartFolder = await getSmartFolder(id, authorId);
    List<Map<String, dynamic>> result;

    // NodeID's with matching tags
    List<String> NoteIds = [];
    for (var tagName in smartFolder.folder_tags) {
      final tagResult = await database.query(
        Tags.TABLE_NAME,
        columns: [Tags.NOTE_ID],
        where: "${Tags.NAME} = ?",
        whereArgs: [tagName],
      );

      for (var tagMap in tagResult) {
        if (tagMap[Tags.NOTE_ID] != null) {
          final folderID = tagMap[Tags.NOTE_ID] as String;
          NoteIds.add("'$folderID'");
        }
      }
    }

    try {
      String NoteIdsString = NoteIds.join(", ");

      result = await database.query(Notes.TABLE_NAME,
        where:
        "${Notes.DELETED} != 1 and ( ${Notes.AUTHOR_ID} = '$authorId' or ${Notes.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' ) AND ${Notes.ID} IN ($NoteIdsString)",
        orderBy: "${Notes.CREATED_AT} DESC"
      );

    } catch (e) {
      log.e("Local database query for fetching smart folder content failed $e");
      throw const DatabaseQueryException();
    }

    return result.map((noteMap) => NoteModel.fromJson(noteMap)).toList();
  }
}
