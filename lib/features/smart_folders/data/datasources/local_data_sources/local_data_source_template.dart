import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/smart_folders/data/models/smart_folders_model.dart';

abstract class ISmartFoldersLocalDataSource {
  /// Saves smart folder as new record in database
  ///
  /// Throws [DatabaseInsertionException] if something goes wrong
  Future<void> saveSmartFolder(Map<String, dynamic> smartFolderMap);

  /// Fetches all smart folders
  ///
  /// Throws [DatabaseQueryException] if something goes wrong
  Future<List<SmartFolderModel>> fetchSmartFolders(
      {required String authorId, List<String>? folderIds});

  /// Fetches the smart folder with given id
  ///
  /// Throws [DatabaseQueryException] if something goes wrong
  Future<SmartFolderModel> getSmartFolder(String id, String authorId);

  /// Updates the smart folder using its id present in model
  ///
  /// Throws [DatabaseUpdateException] if something goes wrong
  Future<void> updateSmartFolder(Map<String, dynamic> smartFolderMap, String authorId);

  /// Deletes the smart folder from id
  ///
  /// Throws [DatabaseDeleteException] if something goes wrong
  Future<void> deleteSmartFolder(String id, String authorId);

  /// Returns all SmartFolder ID's
  Future<List<String>> getAllSmartFolderIds(String authorId);

  /// Generates SmartFolder index for all folders, used for syncing to cloud
  Future<List<Map<String, dynamic>>> getSmartFolderIndex(String authorId);

  /// Search smart folders based on searchText, startDate and endDate
  Future<List<SmartFolderModel>> searchSmartFolders(String authorId,
      {String? searchText,
        DateTime? startDate,
        DateTime? endDate,
        List<String>? tags});

  /// Fetches all notes that are inside a specific smart folder (containing at least one of their tags)
  Future<List<NoteModel>> fetchSmartFolderContent(String id, String authorId);
}
