import 'dart:convert';
import 'dart:io';

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/sync/data/datasources/google_oauth_client.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/oauth_client_templdate.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/oauth_key_data_source_template.dart';
import 'package:dairy_app/features/sync/domain/repositories/oauth_repository_template.dart';

final log = printer("OAuthRepository");

const appFolderName = "my dairy";
const indexFileName = "index";

class OAuthRepository implements IOAuthRepository {
  final INotesRepository notesRepository;
  late IOAuthClient oAuthClient;

  OAuthRepository({required this.notesRepository});

  @override
  Future<bool> initializeOAuthRepository() async {
    try {
      _initializeOAuthClient();
      log.i("successfully initalized oauth client");

      await oAuthClient.initialieClient();
      log.i("successfully initalized oauth client dependencies");

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  /// Checks if the project folder is present, if not initializes new project structure
  ///
  /// Can be called in the beginning when no folder exists, or if the project folder exists
  /// and index is corrupted (which isn't the ideal case)
  ///
  /// returns true if everything works, false if somethign goes wrong
  @override
  Future<bool> initializeNewFolderStructure() async {
    try {
      bool isAppFolderPresent =
          await oAuthClient.isFilePresent(appFolderName, folder: true);
      if (!isAppFolderPresent) {
        log.i("app folder is not present, starting bulk upload");
        return await bulkUploadEverything();
      }

      bool isIndexFolderPresent =
          await oAuthClient.isFilePresent(indexFileName + ".json");
      if (!isIndexFolderPresent) {
        log.i("Index file is not present, starting bulk upload");
        return await bulkUploadEverything();
      }

      bool isNotesSynced = await diffEachNoteAndSync();
      if (!isNotesSynced) {
        log.w("Could not sync notes");
        return false;
      }

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  /// Deletes the app folder if exists and bul uploads everything from local database
  ///
  /// ideally should be done only the first time
  Future<bool> bulkUploadEverything() async {
    try {
      // delete the main app folder
      bool isAppFolderDeleted =
          await oAuthClient.deleteFile(appFolderName, folder: true);
      if (!isAppFolderDeleted) {
        log.e("Could not delete the app folder");
        return false;
      }

      // create the app folder
      bool isAppFolderCreated = await oAuthClient.createFolder(appFolderName);
      if (!isAppFolderCreated) {
        log.e("Could not create app folder");
        return false;
      }

      var result = await notesRepository.getAllNoteIds();

      return result.fold((e) {
        log.e(e);
        log.i("failed to fetch note ID's, aborting bulk upload");
        return false;
      }, (data) async {
        for (var noteId in data) {
          // upload all notes and their assets
          bool isNoteUploaded = await uploAdSingleNote(noteId);
          if (!isNoteUploaded) {
            log.e("failed to upload note with id $noteId");
            return false;
          }
        }

        // upload index
        var result = await notesRepository.generateNotesIndex();

        return result.fold((e) {
          log.e("fetching of notes index failed");
          return false;
        }, (notesIndex) async {
          bool isIndexFileUploaded = await oAuthClient.uploadFile(
            fileContent: jsonEncode(notesIndex),
            fileName: indexFileName,
            fileExtension: "json",
            parentFolder: appFolderName,
          );
          if (!isIndexFileUploaded) {
            return false;
          }

          log.i("Bulk initialization complete");

          return true;
        });
      });
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  Future<bool> uploAdSingleNote(String noteId) async {
    try {
      // fetch the note from repository
      var result = await notesRepository.getNote(noteId);
      return result.fold((e) {
        log.e(e);
        return false;
      }, (note) async {
        // Create the parent folder for post
        bool isPostParentFolderCreated = await oAuthClient.createFolder(note.id,
            parentFolder: appFolderName);
        if (!isPostParentFolderCreated) {
          log.e("failed to create parent folder for note id ${note.id}");
          return false;
        }

        await oAuthClient.uploadFile(
            fileContent: jsonEncode(note.toJson()),
            fileName: "post-body",
            fileExtension: "json",
            parentFolder: note.id);

        // upload all the note assets
        for (var asset in note.assetDependencies) {
          bool isAssetUploaded = await oAuthClient.uploadFile(
              file: File(asset.assetPath), parentFolder: note.id);
          if (!isAssetUploaded) {
            log.e("Could not upload the asset");
            return false;
          }
        }
        return true;
      });
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  @override
  Future<bool> diffEachNoteAndSync() async {
    try {
      // Download the index file
      await oAuthClient.downloadFile("index.json");
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Chooses the appropriate OAuthClient as per user choice and initializes it
  void _initializeOAuthClient() {
    oAuthClient = GoogleOAuthClient(
      oAuthKeyDataSource: sl<IOAuthKeyDataSource>(),
    );
  }
}
