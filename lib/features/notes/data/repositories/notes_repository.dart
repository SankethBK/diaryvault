import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as p;

final log = printer("NotesRepository");

class NotesRepository implements INotesRepository {
  final INotesLocalDataSource notesLocalDataSource;
  final AuthSessionBloc authSessionBloc;

  NotesRepository({
    required this.notesLocalDataSource,
    required this.authSessionBloc,
  });

  @override
  Future<Either<NotesFailure, List<NoteModel>>> fetchNotes() async {
    try {
      // since userId is fetched asynchronously, it will be null first time
      final userId = authSessionBloc.state.user?.id ?? "";
      var notesList = await notesLocalDataSource.fetchNotes(userId);
      return Right(notesList);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, NoteModel>> getNote(String id) async {
    try {
      var note = await notesLocalDataSource.getNote(
          id, authSessionBloc.state.user!.id);
      return Right(note);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, void>> saveNote(
    Map<String, dynamic> noteMap, {
    bool dontModifyAnyParameters = false,
  }) async {
    try {
      if (dontModifyAnyParameters == false) {
        List<NoteAsset> allNoteAssets = noteMap["asset_dependencies"];
        List<String> usedNoteAssets = _parseAssets(noteMap["body"]);

        for (var noteAsset in allNoteAssets) {
          if (!usedNoteAssets.contains(noteAsset.assetPath)) {
            notesLocalDataSource.deleteFile(noteAsset.assetPath);
          }
        }

        noteMap["asset_dependencies"].removeWhere(
            (noteAsset) => !usedNoteAssets.contains(noteAsset.assetPath));

        // calculate note hash
        String noteBodyWithAssetPathsRemoved =
            _replaceAssetPathsByAssetNames(noteMap["body"]);

        var _hash = _generateHash(noteMap["title"] +
            noteMap["created_at"].toString() +
            noteBodyWithAssetPathsRemoved);

        noteMap["hash"] = _hash;
      }

      //! bad but i don't have enough time to re-structure it
      noteMap["author_id"] = authSessionBloc.state.user!.id;

      await notesLocalDataSource.saveNote(noteMap);
      return const Right(null);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, void>> updateNote(
      Map<String, dynamic> noteMap) async {
    try {
      List<NoteAsset> allNoteAssets = noteMap["asset_dependencies"];
      List<String> usedNoteAssets = _parseAssets(noteMap["body"]);

      for (var noteAsset in allNoteAssets) {
        if (!usedNoteAssets.contains(noteAsset.assetPath)) {
          notesLocalDataSource.deleteFile(noteAsset.assetPath);
        }
      }

      noteMap["asset_dependencies"].removeWhere(
          (noteAsset) => !usedNoteAssets.contains(noteAsset.assetPath));

      // calculate note hash
      String noteBodyWithAssetPathsRemoved =
          _replaceAssetPathsByAssetNames(noteMap["body"]);

      var _hash = _generateHash(noteMap["title"] +
          noteMap["created_at"].toString() +
          noteBodyWithAssetPathsRemoved);

      noteMap["hash"] = _hash;

      await notesLocalDataSource.updateNote(
          noteMap, authSessionBloc.state.user!.id);
      return const Right(null);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, List<NotePreview>>> fetchNotesPreview(
      {String? searchText, DateTime? startDate, DateTime? endDate}) async {
    try {
      if (searchText != null || startDate != null || endDate != null) {
        var notesList = await notesLocalDataSource.searchNotes(
          authSessionBloc.state.user!.id,
          searchText: searchText,
          startDate: startDate,
          endDate: endDate,
        );
        return Right(notesList);
      }
      var notesList = await notesLocalDataSource
          .fetchNotesPreview(authSessionBloc.state.user!.id);
      return Right(notesList);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, void>> deleteNotes(List<String> noteList,
      {bool hardDeletion = false}) async {
    try {
      for (var noteId in noteList) {
        await notesLocalDataSource.deleteNote(
            noteId, authSessionBloc.state.user!.id,
            hardDeletion: hardDeletion);
      }
      return const Right(null);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, List<String>>> getAllNoteIds() async {
    try {
      var noteIdList = await notesLocalDataSource
          .getAllNoteIds(authSessionBloc.state.user!.id);
      return Right(noteIdList);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, List<Map<String, dynamic>>>>
      generateNotesIndex() async {
    try {
      var notesIndex = await notesLocalDataSource
          .getNotesIndex(authSessionBloc.state.user!.id);
      return Right(notesIndex);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  String replaceOldAssetPathsWithNewAssetPaths(
      String noteBody, Map<String, dynamic> assetPathMap) {
    var noteBodyMap = jsonDecode(noteBody);

    for (var noteElement in noteBodyMap) {
      if (noteElement.containsKey("insert") &&
          noteElement["insert"].runtimeType != String) {
        // replace paths from assetPathMap for image and video

        if (noteElement["insert"].containsKey("image") &&
            !(noteElement["insert"]["image"] as String).startsWith("http")) {
          noteElement["insert"]["image"] =
              assetPathMap[p.basename(noteElement["insert"]["image"])];
        } else if (noteElement["insert"].containsKey("video") &&
            !(noteElement["insert"]["video"] as String).startsWith("http")) {
          noteElement["insert"]["video"] =
              assetPathMap[p.basename(noteElement["insert"]["video"])];
        }
      }
    }

    return jsonEncode(noteBodyMap);
  }

  //* utility functions

  /// Used to extract assets from note body
  List<String> _parseAssets(String noteBody) {
    var noteBodyMap = jsonDecode(noteBody);
    List<String> noteAssets = [];

    //! currently treats web images and videos also as assets, put a way to distinguish them
    //! Luckily parsed assets are only used to subtract from allAssets, since web images are not recorded in allAssets
    //! We don't need extra check for web images and videos

    for (var noteElement in noteBodyMap) {
      if (noteElement.containsKey("insert") &&
          noteElement["insert"].runtimeType != String) {
        var assetMap = noteElement["insert"];
        String assetType = assetMap.containsKey("image") ? "image" : "video";
        noteAssets.add(assetMap[assetType]);
      }
    }

    return noteAssets;
  }

  /// used to replace absolute paths of assets by their asset names, so that hash values
  /// are same in all devices
  String _replaceAssetPathsByAssetNames(String noteBody) {
    var noteBodyMap = jsonDecode(noteBody);

    for (Map<String, dynamic> noteElement in noteBodyMap) {
      if (noteElement.containsKey("insert") &&
          noteElement["insert"].runtimeType != String) {
        // check for image and video types and replace their absolute paths with file names
        // Assuming all web images and videos start with http (even https starts with http)

        if (noteElement["insert"].containsKey("image") &&
            !(noteElement["insert"]["image"] as String).startsWith("http")) {
          noteElement["insert"]["image"] =
              p.basename(noteElement["insert"]["image"]);
        } else if (noteElement["insert"].containsKey("video") &&
            !(noteElement["insert"]["video"] as String).startsWith("http")) {
          noteElement["insert"]["video"] =
              p.basename(noteElement["insert"]["video"]);
        }
      }
    }

    return jsonEncode(noteBodyMap);
  }

  String _generateHash(String text) {
    var bytes = utf8.encode(text);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }
}
