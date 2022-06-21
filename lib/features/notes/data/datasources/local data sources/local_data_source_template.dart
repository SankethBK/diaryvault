import 'package:dairy_app/features/notes/data/models/notes_model.dart';

abstract class INotesLocalDataSource {
  /// Saves notes as new record in database
  ///
  /// Throws [DatabaseInsertionException] if something goes wrong
  Future<void> saveNote(Map<String, dynamic> noteMap);

  /// Fetches all notes
  ///
  /// Throws [DatabaseQueryException] if something goes wrong
  ///
  /// TODO: add support for pagination
  Future<List<NoteModel>> fetchNotes();

  // Fetch all notes with only columns required to display the preview
  Future<List<NotePreviewModel>> fetchNotesPreview();

  /// Fetches the note with given id
  ///
  /// DatabaseDeleteException
  Future<NoteModel> getNote(String id);

  /// Updates the note using its id present in model
  ///
  /// Throws [DatabaseUpdateException] if something goes wrong
  Future<void> updateNote(Map<String, dynamic> noteMap);

  /// Deletes the note from id
  ///
  /// Throws [DatabaseDeleteException] if something goes wrong
  Future<void> deleteNote(String id, {bool hardDeletion = false});

  /// Deletes the file with given filePath
  Future<void> deleteFile(String filePath);

  /// Returns all note ID's
  Future<List<String>> getAllNoteIds();

  /// Generates notes index for all notes, used for syncing to cloud
  Future<List<Map<String, dynamic>>> getNotesIndex();

  /// Search notes based on searchText, startDate and endDate
  Future<List<NotePreviewModel>> searchNotes(
      {String? searchText, DateTime? startDate, DateTime? endDate});
}
