import 'package:dairy_app/features/notes/core/exports.dart';
import 'package:dartz/dartz.dart';

abstract class INotesRepository {
  /// Saves the note into local database, it involves some computation on [noteMap]
  /// If [dontModifyAnyParameters] is true, then it skips all the computation and saves the note directly
  /// This is useful for saving notes downloaded from cloud as we should not change some parameters like lastModifieds
  Future<Either<NotesFailure, void>> saveNote(
    Map<String, dynamic> noteMap, {
    bool dontModifyAnyParameters = false,
  });

  Future<Either<NotesFailure, List<NoteModel>>> fetchNotes();

  Future<Either<NotesFailure, NoteModel>> getNote(String id);

  Future<Either<NotesFailure, void>> updateNote(Map<String, dynamic> noteMap);

  Future<Either<NotesFailure, List<NotePreview>>> fetchNotesPreview(
      {String? searchText, DateTime? startDate, DateTime? endDate});

  /// By default it does soft deletion, if hardDeletion = true, it does hard deletion
  Future<Either<NotesFailure, void>> deleteNotes(List<String> noteList,
      {bool hardDeletion = false});

  Future<Either<NotesFailure, List<String>>> getAllNoteIds();

  Future<Either<NotesFailure, List<Map<String, dynamic>>>> generateNotesIndex();

  String replaceOldAssetPathsWithNewAssetPaths(
      String noteBody, Map<String, dynamic> assetPathMap);
}
