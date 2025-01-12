import 'package:dairy_app/features/notes/data/models/notes_model.dart';

abstract class INotesLocalDataSource {
  /// Saves notes as new record in database
  ///
  /// Throws [DatabaseInsertionException] if something goes wrong
  Future<void> saveNote(Map<String, dynamic> noteMap);

  /// Fetches all notes
  ///
  /// Throws [DatabaseQueryException] if something goes wrong
  Future<List<NoteModel>> fetchNotes(
      {required String authorId, List<String>? noteIds});

  // Fetch all notes with only columns required to diplay the preview
  Future<List<NotePreviewModel>> fetchNotesPreview(String authorId);

  /// Fetches the note with given id
  ///
  /// DatabaseDeleteException
  Future<NoteModel> getNote(String id, String authorId);

  /// Updates the note using its id present in model
  ///
  /// Throws [DatabaseUpdateException] if something goes wrong
  Future<void> updateNote(Map<String, dynamic> noteMap, String authorId);

  /// Deletes the note from id
  ///
  /// Throws [DatabaseDeleteException] if something goes wrong
  Future<void> deleteNote(String id, String authorId,
      {bool hardDeletion = false});

  /// Deletes the file with given filePath
  Future<void> deleteFile(String filePath);

  /// Returns all note ID's
  Future<List<String>> getAllNoteIds(String authorId);

  /// Generates notes index for all notes, used for syncing to cloud
  Future<List<Map<String, dynamic>>> getNotesIndex(String authorId);

  /// Search notes based on searchText, startDate and endDate
  Future<List<NotePreviewModel>> searchNotes(String authorId,
      {String? searchText,
      DateTime? startDate,
      DateTime? endDate,
      List<String>? tags});

  /// Retrieve all tags from all notes to display autocompletion list for tag input field
  Future<List<String>> getAllTags();
}
