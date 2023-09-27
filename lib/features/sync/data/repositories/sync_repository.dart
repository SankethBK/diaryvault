import 'dart:convert';
import 'dart:io' as io;

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/network/network_info.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/sync/core/failures.dart';
import 'package:dairy_app/features/sync/data/datasources/dropbox_sync_client.dart';
import 'package:dairy_app/features/sync/data/datasources/google_drive_sync_client.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/sync_client_template.dart';
import 'package:dairy_app/features/sync/domain/repositories/sync_repository_template.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as p;

final log = printer("SyncRepository");

const appFolderName = "my dairy";
const indexFileName = "index";
const lockFileName = "lockfile";

class SyncRepository implements ISyncRepository {
  final INotesRepository notesRepository;
  final UserConfigCubit userConfigCubit;
  late ISyncClient syncClient;
  final INetworkInfo networkInfo;

  SyncRepository({
    required this.notesRepository,
    required this.networkInfo,
    required this.userConfigCubit,
  });

  @override
  Future<Either<SyncFailure, bool>> initializeSyncRepository() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(SyncFailure.noInternetConnection());
      }

      var res = _initializeSyncClient();
      if (res == false) {
        return Left(SyncFailure.noSyncSourceSelected());
      }

      log.i("successfully initalized sync client");

      res = await syncClient.initialieClient();
      // if res is false here, cancel the sync as in case of dropbox authentication will
      // happen in browser
      if (res == false) {
        return Left(SyncFailure.stopSync());
      }

      log.i("successfully initalized sync client dependencies");

      return const Right(true);
    } catch (e) {
      log.e(e);
      return Left(SyncFailure.connectionFailed());
    }
  }

  /// Checks if the project folder is present, if not initializes new project structure
  ///
  /// Can be called in the beginning when no folder exists, or if the project folder exists
  /// and index is corrupted (which isn't the ideal case)
  ///
  /// returns true if everything works, false if somethign goes wrong
  @override
  Future<Either<SyncFailure, bool>> initializeNewFolderStructure() async {
    try {
      bool isAppFolderPresent = await syncClient.isFilePresent(appFolderName,
          folder: true, fullFilePath: "/$appFolderName");
      if (!isAppFolderPresent) {
        log.i("app folder is not present, starting bulk upload");
        final res = await bulkUploadEverything();
        if (res) {
          return Right(res);
        }
        return Left(SyncFailure.unknownError());
      }

      bool isIndexFolderPresent = await syncClient.isFilePresent(
          indexFileName + ".json",
          fullFilePath: "/$appFolderName/$indexFileName.json");
      if (!isIndexFolderPresent) {
        log.i("Index file is not present, starting bulk upload");
        return Right(await bulkUploadEverything());
      }

      // if the folder is locked
      bool isAppFolderLocked = await isFolderLocked();
      if (isAppFolderLocked) {
        log.w("Folder is locked, aborting sync");
        return Left(SyncFailure.anotherDeviceIsSyncing());
      }

      log.i("uploading lockfile for diff and sync");
      await syncClient.uploadFile(
        fileContent: "",
        fileName: lockFileName,
        parentFolder: appFolderName,
        fullFilePath: "/$appFolderName/$lockFileName",
      );

      bool isNotesSynced = await diffEachNoteAndSync();

      log.i("Removing lockfile for diff and sync");
      await syncClient.deleteFile(lockFileName,
          fullFilePath: "/$appFolderName/$lockFileName");

      if (!isNotesSynced) {
        log.w("Could not sync notes");
        return Left(SyncFailure.unknownError());
      }

      return const Right(true);
    } catch (e) {
      log.e(e);
      return Left(SyncFailure.unknownError());
    }
  }

  /// Deletes the app folder if exists and bul uploads everything from local database
  ///
  /// ideally should be done only the first time
  Future<bool> bulkUploadEverything() async {
    try {
      // delete the main app folder
      bool isAppFolderDeleted = await syncClient.deleteFile(appFolderName,
          folder: true, fullFilePath: "/$appFolderName");
      if (!isAppFolderDeleted) {
        log.e("Could not delete the app folder");
        return false;
      }

      // create the app folder
      bool isAppFolderCreated = await syncClient.createFolder(appFolderName,
          fullFolderPath: "/$appFolderName");
      if (!isAppFolderCreated) {
        log.e("Could not create app folder");
        return false;
      }

      //* upload lockfile
      log.i("uploading lockfile");
      await syncClient.uploadFile(
        fileContent: "test",
        fileName: lockFileName,
        parentFolder: appFolderName,
        fullFilePath: "/$appFolderName/$lockFileName",
      );

      var result = await notesRepository.getAllNoteIds();

      return result.fold((e) {
        log.e(e);
        log.i("failed to fetch note ID's, aborting bulk upload");
        return false;
      }, (data) async {
        for (var noteId in data) {
          // upload all notes and their assets
          await _uploadSingleNote(noteId);
        }

        // upload index
        var result = await notesRepository.generateNotesIndex();

        //* Remove the lockfile, despite of the process is success or failure

        return result.fold((e) async {
          log.e("fetching of notes index failed");

          await syncClient.deleteFile(lockFileName,
              fullFilePath: "/$appFolderName/$lockFileName");
          log.i("removing lockfile");

          return false;
        }, (notesIndex) async {
          bool isIndexFileUploaded = await syncClient.uploadFile(
              fileContent: jsonEncode(notesIndex),
              fileName: indexFileName + ".json",
              parentFolder: appFolderName,
              fullFilePath: "/$appFolderName/$indexFileName.json");

          log.i("removing lockfile");
          await syncClient.deleteFile(lockFileName,
              fullFilePath: "/$appFolderName/$lockFileName");

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
      var _globalNotesIndex = jsonDecode(await syncClient.downloadFile(
        "index.json",
        fullFilePath: "/$appFolderName/index.json",
      ));

      List<Map<String, dynamic>> globalNotesIndex = [];
      for (var noteIndex in _globalNotesIndex) {
        globalNotesIndex.add(noteIndex);
      }

      var result = await notesRepository.generateNotesIndex();
      List<Map<String, dynamic>> localNotesIndex = [];

      result.fold((e) {
        log.e("fetching of notes index failed");
        return false;
      }, (notesIndex) {
        localNotesIndex = notesIndex;
      });

      log.d("global notes index = $globalNotesIndex");
      // log.d("local notes index = $localNotesIndex");

      // Copy of global notes index, as we have to update index for each diff and we cannot store
      // updated index in globalNotesIndex as we should not change array while iterating it
      var globalNotesIndexCopy = globalNotesIndex.map((e) => {...e}).toList();

      // first iterate through the global notes map and sort out and all the stuff with
      // corresponding local notes index, then deal with the remaining notes in local notes index
      for (var globalNote in globalNotesIndex) {
        var localNote = _findNoteWithGivenId(localNotesIndex, globalNote["id"]);

        log.d("globalNote = $globalNote");
        log.d("localNote = $localNote");

        // remove the global note id from allLocalNoteId's to identify the note to be inserted
        localNotesIndex
            .removeWhere((noteIndex) => noteIndex["id"] == globalNote["id"]);

        // global note is deleted
        if (globalNote["deleted"] == 1) {
          log.i("global note is deleted");

          if (localNote == null || localNote["deleted"] == 1) {
            log.i(
                "local note also does not exists or already deleted, so no change");
            continue;
          }

          // local note exists, tie break based on last modified
          if (localNote["last_modified"] < globalNote["last_modified"]) {
            log.i("delete the local note");
            await notesRepository.deleteNotes([localNote["id"]]);
          } else {
            // hard delete + new upload to cloud
            log.i("modifying the note in cloud");
            globalNotesIndexCopy = await deleteNoteInCloud(
              globalNote["id"],
              globalNotesIndexCopy,
              hardDeletion: true,
            );
            globalNotesIndexCopy = await createNoteInCloud(
                noteIndex: localNote, globalIndex: globalNotesIndexCopy);
          }
        }
        // global note is not deleted
        else {
          log.i("global note is not deleted");
          // local note does not exists
          if (localNote == null) {
            log.i("downloading and inserting the local note locally");
            await downloadAndInsertNote(globalNote["id"]);
          }

          // both have same hash, ignore
          else if (localNote["hash"] == globalNote["hash"]) {
            log.i("hashes are same, so no change");
            continue;
          }

          // local note is deleted
          else if (localNote["deleted"] == 1) {
            // tiebraker based on last modified
            if (localNote["last_modified"] > globalNote["last_modified"]) {
              log.i("soft delete global note");

              globalNotesIndexCopy = await deleteNoteInCloud(
                  globalNote["id"], globalNotesIndexCopy,
                  lastModified: localNote["last_modified"]);
            } else {
              // hard delete local note and insert a new copy from global (because we don't have
              // function to update) soft deleted notes
              log.i(
                  "updating notes on local by hard deletion and new insertion");

              await notesRepository
                  .deleteNotes([localNote["id"]], hardDeletion: true);

              await downloadAndInsertNote(localNote["id"]);
            }
          }

          // one of them is updates, tiebraker based on last modified
          else if (localNote["hash"] != globalNote["hash"]) {
            if (localNote["last_modified"] > globalNote["last_modified"]) {
              // update the global note by hard deletion followed by insertion

              log.i(
                  "updating the global notes by hard deletion and new insertion");
              globalNotesIndexCopy = await deleteNoteInCloud(
                  globalNote["id"], globalNotesIndexCopy,
                  hardDeletion: true);

              globalNotesIndexCopy = await createNoteInCloud(
                  noteIndex: localNote, globalIndex: globalNotesIndexCopy);
            } else {
              // update the local note by hard deletion followed by insertion
              log.i(
                  "updating notes on local by hard deletion and new insertion");

              await notesRepository
                  .deleteNotes([localNote["id"]], hardDeletion: true);

              await downloadAndInsertNote(localNote["id"]);
            }
          }
        }
      }

      log.i("processing of global notes finished\n\n");

      // upload the new notes to cloud
      for (var noteIndex in localNotesIndex) {
        // upload it only if it's not deleted locally
        if (noteIndex["deleted"] == 0) {
          log.i("fresh upload of ${noteIndex["id"]} to cloud");
          globalNotesIndexCopy = await createNoteInCloud(
              noteIndex: noteIndex, globalIndex: globalNotesIndexCopy);
        }
      }

      log.i("global notes index at end = \n $globalNotesIndexCopy");

      await syncClient.updateLastSynced();
      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  Future<void> _uploadSingleNote(String noteId) async {
    try {
      // fetch the note from repository
      var result = await notesRepository.getNote(noteId);
      return result.fold((e) {
        log.e(e);
      }, (note) async {
        // Create the parent folder for post
        bool isPostParentFolderCreated = await syncClient.createFolder(note.id,
            parentFolder: appFolderName,
            fullFolderPath: "/$appFolderName/${note.id}");
        if (!isPostParentFolderCreated) {
          log.e("failed to create parent folder for note id ${note.id}");
        }

        await syncClient.uploadFile(
          fileContent: jsonEncode(note.toJson()),
          fileName: noteId + ".json",
          parentFolder: note.id,
          fullFilePath: "/$appFolderName/${note.id}/$noteId.json",
        );

        // upload all the note assets
        for (var asset in note.assetDependencies) {
          bool isAssetUploaded = await syncClient.uploadFile(
            file: io.File(asset.assetPath),
            parentFolder: note.id,
            fullFilePath:
                "/$appFolderName/${note.id}/${p.basename(asset.assetPath)}",
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
  Future<List<Map<String, dynamic>>> createNoteInCloud({
    required Map<String, dynamic> noteIndex,
    required List<Map<String, dynamic>> globalIndex,
  }) async {
    log.i("uploading ${noteIndex["id"]} to cloud");
    try {
      // upload note and assets
      await _uploadSingleNote(noteIndex["id"]);

      // update global index and update the file in cloud
      globalIndex.add(noteIndex);

      await syncClient.updateFile(
          fileName: "index.json",
          fileContent: jsonEncode(globalIndex),
          fullFilePath: "/$appFolderName/index.json");

      log.i("uploading ${noteIndex["id"]} to cloud successful");
      // return the updated global index array
      return globalIndex;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  /// Download note with given iD and its assets and insert it locally
  @override
  Future<void> downloadAndInsertNote(String noteId) async {
    try {
      // download the note body which was stored as JSON

      log.i("Downloading $noteId from cloud");
      Map<String, dynamic> newNote = jsonDecode(await syncClient.downloadFile(
        noteId + ".json",
        fullFilePath: "/$appFolderName/$noteId/$noteId.json",
      ));

      log.i("newNote = $newNote");
      // download all assets and record the paths in a map
      // new asset paths will replace old asset paths

      Map<String, String> assetPathMap = {};

      for (var noteAsset in newNote["asset_dependencies"]) {
        String assetName = p.basename(noteAsset["asset_path"]);
        assetPathMap[assetName] = await syncClient.downloadFile(
          assetName,
          outputAsFile: true,
          fullFilePath: "/$appFolderName/$noteId/${p.basename(assetName)}",
        );
      }

      log.i("downloaded note assets = $assetPathMap");

      String newNoteBody = notesRepository
          .replaceOldAssetPathsWithNewAssetPaths(newNote["body"], assetPathMap);

      log.d("new note body = \n $newNoteBody");
      newNote["body"] = newNoteBody;

      // note assets needs to be converted to their respective models
      newNote["asset_dependencies"] = newNote["asset_dependencies"]
          .map((noteAsset) => NoteAssetModel.fromJson(noteAsset))
          .toList();

      // save the notes into database
      await notesRepository.saveNote(newNote, dontModifyAnyParameters: true);

      log.i("Downloading of note $noteId successful");
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> deleteNoteInCloud(
    String noteId,
    List<Map<String, dynamic>> globalIndex, {
    bool hardDeletion = false,
    int? lastModified,
  }) async {
    try {
      log.i("Deleting $noteId on cloud");
      // update the index first and then delete the actual folder to avoid inconsisteny
      if (hardDeletion) {
        globalIndex.removeWhere((noteIndex) => noteIndex["id"] == noteId);
      } else {
        globalIndex = globalIndex
            .map((Map<String, dynamic> noteIndex) => noteIndex["id"] != noteId
                ? noteIndex
                : {...noteIndex, "deleted": 1, "last_modified": lastModified!})
            .toList();
      }

      await syncClient.updateFile(
          fileName: "index.json",
          fileContent: jsonEncode(globalIndex),
          fullFilePath: "/$appFolderName/index.json");

      // delete the note folder
      await syncClient.deleteFile(noteId,
          folder: true, fullFilePath: "/$appFolderName/$noteId");

      log.i("Deletion of $noteId successful");
      return globalIndex;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<bool> isFolderLocked() async {
    try {
      log.i("Starting lockfile check");

      bool isLockfilePresent = await syncClient.isFilePresent(lockFileName,
          fullFilePath: "/$appFolderName/$lockFileName");
      if (!isLockfilePresent) {
        return false;
      }
      // check if it is expired, expiration time: 5 min
      // if createdTime is null, we assume it is expired and delete it

      DateTime? lockedFileCreatedTime = await syncClient.getNoteCreatedTime(
        lockFileName,
        fullFilePath: "/$appFolderName/$lockFileName",
      );

      if (lockedFileCreatedTime == null ||
          DateTime.now().difference(lockedFileCreatedTime).inMinutes > 5) {
        // delete lockfile
        await syncClient.deleteFile(lockFileName,
            fullFilePath: "/$appFolderName/$lockFileName");
        return false;
      }

      return true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  //* Utils

  /// Chooses the appropriate OAuthClient as per user choice and initializes it
  bool _initializeSyncClient() {
    final preferredSyncOption =
        userConfigCubit.state.userConfigModel?.preferredSyncOption;

    if (preferredSyncOption == SyncConstants.googleDrive) {
      syncClient =
          GoogleDriveSyncClient(userConfigCubit: sl<UserConfigCubit>());
      return true;
    } else if (preferredSyncOption == SyncConstants.dropbox) {
      syncClient = DropboxSyncClient(userConfigCubit: sl<UserConfigCubit>());
      return true;
    }

    // if preferred sync option is not set, check if user has logged into
    // any of the sync sources, if so set it as preferred sync source

    final isLoggedIntoGoogleDrive =
        userConfigCubit.state.userConfigModel?.googleDriveUserInfo?.isNotEmpty;

    if (isLoggedIntoGoogleDrive == true) {
      log.i("Setting google drive as sync source as user has logged in");
      userConfigCubit.setUserConfig(
          UserConfigConstants.preferredSyncOption, SyncConstants.googleDrive);
      syncClient =
          GoogleDriveSyncClient(userConfigCubit: sl<UserConfigCubit>());
      return true;
    }

    final isLoggedIntoDropBox =
        userConfigCubit.state.userConfigModel?.dropBoxUserInfo?.isNotEmpty;

    if (isLoggedIntoDropBox == true) {
      log.i("Setting dropbox as sync source as user has logged in");
      userConfigCubit.setUserConfig(
          UserConfigConstants.preferredSyncOption, SyncConstants.dropbox);
      syncClient = DropboxSyncClient(userConfigCubit: sl<UserConfigCubit>());
      return true;
    }

    return false;
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
