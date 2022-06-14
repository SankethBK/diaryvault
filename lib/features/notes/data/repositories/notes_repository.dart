import 'dart:convert';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

final log = printer("NotesRepository");

class NotesRepository implements INotesRepository {
  final INotesLocalDataSource notesLocalDataSource;

  NotesRepository({required this.notesLocalDataSource});

  @override
  Future<Either<NotesFailure, List<NoteModel>>> fetchNotes() async {
    try {
      var notesList = await notesLocalDataSource.fetchNotes();
      return Right(notesList);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, NoteModel>> getNote(String id) async {
    try {
      var note = await notesLocalDataSource.getNote(id);
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
      }

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

      await notesLocalDataSource.updateNote(noteMap);
      return const Right(null);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, List<NotePreview>>> fetchNotesPreview() async {
    try {
      var notesList = await notesLocalDataSource.fetchNotesPreview();
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
        await notesLocalDataSource.deleteNote(noteId,
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
      var noteIdList = await notesLocalDataSource.getAllNoteIds();
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
      var notesIndex = await notesLocalDataSource.getNotesIndex();
      return Right(notesIndex);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  //* utility functions

  List<String> _parseAssets(String noteBody) {
    var noteBodyMap = jsonDecode(noteBody);
    List<String> noteAssets = [];

    // TODO: currently treats web images and videos also as assets, put a way to distinguish them
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
}
