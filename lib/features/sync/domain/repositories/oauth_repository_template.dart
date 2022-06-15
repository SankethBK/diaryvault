import 'package:googleapis/dfareporting/v3_5.dart';

abstract class IOAuthRepository {
  Future<bool> initializeOAuthRepository();

  Future<bool> initializeNewFolderStructure();

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
}
