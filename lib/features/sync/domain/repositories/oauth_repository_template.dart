abstract class IOAuthRepository {
  Future<bool> initializeOAuthRepository();

  Future<bool> initializeNewFolderStructure();

  Future<bool> diffEachNoteAndSync();

  Future<List<Map<String, dynamic>>> uploadSingleNoteAndUpdateIndex(
    Map<String, dynamic> noteIndex,
    List<Map<String, dynamic>> globalIndex,
  );
}
