import 'dart:convert';
import 'dart:io';

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/sync/data/datasources/google_oauth_client.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/oauth_client_templdate.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/oauth_key_data_source_template.dart';
import 'package:dairy_app/features/sync/domain/repositories/oauth_repository_template.dart';
import 'package:googleapis/dfareporting/v3_5.dart';

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
          await uploadSingleNote(noteId);
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

  @override
  Future<bool> diffEachNoteAndSync() async {
    try {
      // Download the index file
      log.i("Started diffEachNoteAndSync");
      var globalNotesIndex =
          jsonDecode(await oAuthClient.downloadFile("index.json"));

      var result = await notesRepository.generateNotesIndex();
      List<Map<String, dynamic>> localNotesIndex = [];

      result.fold((e) {
        log.e("fetching of notes index failed");
        return false;
      }, (notesIndex) {
        localNotesIndex = notesIndex;
      });

      // log.d("global notes index = $globalNotesIndex");
      // log.d("local notes index = $localNotesIndex");

      // Copy of global notes index, as we have to update index for each diff and we cannot store
      // updated index in globalNotesIndex as we should not change array while iterating it
      var globalNotesIndexCopy =
          globalNotesIndex.map((e) => {...(e as Map<String, dynamic>)});
      // log.d("global notes index copy $globalNotesIndexCopy");

      // first iterate through the global notes map and sort out and all the stuff with
      // corresponding local notes index, then deal with the remaining notes in local notes index
      for (var globalNote in globalNotesIndex) {
        var localNote = _findNoteWithGivenId(localNotesIndex, globalNote["id"]);

        // global note is deleted
        if (globalNote["deleted"] == 1) {
          // local note also does not exists or already deleted, so no change
          if (localNote == null || localNote["deleted"] == 1) {
            continue;
          }

          // local note exists, tie break based on last modified
          if (localNote["last_modified"] < globalNote["last_modified"]) {
            // delete the local note
            await notesRepository.deleteNotes([localNote["id"]]);
          }

          // upload the note to global
          else {
            globalNotesIndexCopy = await uploadSingleNoteAndUpdateIndex(
                localNote, globalNotesIndexCopy);
          }
        }
        // global note is not deleted
        else {
          // local note does not exists
          if (localNote == null) {
            // insert the local note
          }

          // both have same hash, ignore
          else if (localNote["hash"] == globalNote["hash"]) {
            continue;
          }

          // local note is deleted
          else if (localNote["deleted"] == 1) {
            // tiebraker based on last modified
            if (localNote["last_modified"] > globalNote["last_modified"]) {
              // soft delete global note
            } else {
              // hard delete local note and insert a new copy from global (because we don't have
              // function to update) soft deleted notes
            }
          }

          // one of them is updates, tiebraker based on last modified
          else if (localNote["hash"] != globalNote["hash"]) {
            if (localNote["last_modified"] > globalNote["last_modified"]) {
              // update the global note by hard deletion followed by insertion
            } else {
              // update the local note by hard deletion followed by insertion
            }
          }
        }

        if (localNote != null) {
          // 1. local note is present, and its hash is equal to hash of global note, so no change
          if (localNote["hash"] == globalNote["hash"]) {
            continue;
          }

          // 2. local note is present, but its deleted
          else if (localNote["deleted"] == 1) {
            if (localNote["last_modified"] > 3) {}
          }
        } else {}
      }

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  Future<void> uploadSingleNote(String noteId) async {
    try {
      // fetch the note from repository
      var result = await notesRepository.getNote(noteId);
      return result.fold((e) {
        log.e(e);
      }, (note) async {
        // Create the parent folder for post
        bool isPostParentFolderCreated = await oAuthClient.createFolder(note.id,
            parentFolder: appFolderName);
        if (!isPostParentFolderCreated) {
          log.e("failed to create parent folder for note id ${note.id}");
        }

        await oAuthClient.uploadFile(
            fileContent: jsonEncode(note.toJson()),
            fileName: "post-body",
            fileExtension: "json",
            parentFolder: note.id);

        // upload all the note assets
        for (var asset in note.assetDependencies) {
          bool isAssetUploaded = await oAuthClient.uploadFile(
            file: File(asset.assetPath),
            parentFolder: note.id,
          );
          if (!isAssetUploaded) {
            log.e("Could not upload the asset");
          }
        }
      });
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  /// Updates the note, adds the noteIndex map to global index and writes global index into index.json
  @override
  Future<List<Map<String, dynamic>>> uploadSingleNoteAndUpdateIndex(
    Map<String, dynamic> noteIndex,
    List<Map<String, dynamic>> globalIndex,
  ) async {
    try {
      // upload note and assets
      await uploadSingleNote(noteIndex["id"]);

      // update global index and update the file in cloud
      globalIndex.add(noteIndex);
      await oAuthClient.updateFile("index.json", jsonEncode(globalIndex));

      // return the updated global index array
      return globalIndex;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  //* Utils

  /// Chooses the appropriate OAuthClient as per user choice and initializes it
  void _initializeOAuthClient() {
    oAuthClient = GoogleOAuthClient(
      oAuthKeyDataSource: sl<IOAuthKeyDataSource>(),
    );
  }

  Map<String, dynamic>? _findNoteWithGivenId(
      List<Map<String, dynamic>> notesIndex, String noteId) {
    for (var note in notesIndex) {
      if (note["id"] == noteId) {
        return note;
      }
    }
    return null;
  }
}
