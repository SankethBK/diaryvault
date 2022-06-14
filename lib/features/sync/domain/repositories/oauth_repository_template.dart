abstract class IOAuthRepository {
  Future<bool> initializeOAuthRepository();

  Future<bool> initializeNewFolderStructure();

  Future<bool> diffEachNoteAndSync();

  Future<List<Map<String, dynamic>>> createNoteInCloud({
    required Map<String, dynamic> noteIndex,
    required List<Map<String, dynamic>> globalIndex,
  });

  Future<void> downloadAndInsertNote(String noteId);

  Future<List<Map<String, dynamic>>> deleteNoteInCloud(
    String noteId,
    List<Map<String, dynamic>> globalIndex,
  );
}
