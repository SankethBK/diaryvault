abstract class IOAuthRepository {
  Future<bool> initializeOAuthRepository();
  Future<bool> initializeNewFolderStructure();
  Future<bool> diffEachNoteAndSync();
}
