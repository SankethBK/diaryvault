import 'package:dairy_app/features/sync/core/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IOAuthRepository {
  Future<Either<SyncFailure, bool>> initializeOAuthRepository();

  Future<Either<SyncFailure, bool>> initializeNewFolderStructure();

  Future<bool> diffEachNoteAndSync();

  Future<List<Map<String, dynamic>>> createNoteInCloud({
    required Map<String, dynamic> noteIndex,
    required List<Map<String, dynamic>> globalIndex,
  });

  Future<void> downloadAndInsertNote(String noteId);

  /// used to perform both hard deletion and soft deletion, need to update last modified also in soft deletion
  Future<List<Map<String, dynamic>>> deleteNoteInCloud(
    String noteId,
    List<Map<String, dynamic>> globalIndex, {
    bool hardDeletion = false,
    int? lastModified,
  });

  /// Check if lockfile is present, or expired
  /// Returns true if the folder is locked, else false
  Future<bool> isFolderLocked();
}
