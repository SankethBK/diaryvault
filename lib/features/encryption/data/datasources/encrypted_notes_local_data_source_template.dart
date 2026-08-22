import 'package:dairy_app/features/notes/data/models/notes_model.dart';

abstract class IEncryptedNotesLocalDataSource {
  /// Keychain columns from any encrypted note (fresh-device hydration).
  /// Returns null when no encrypted notes exist.
  Future<Map<String, dynamic>?> fetchKeychainRow();

  /// All encrypted notes (ciphertext form) with tags and assets.
  Future<List<NoteModel>> fetchEncryptedNotes(String authorId);

  /// Single encrypted note in raw (ciphertext) form, null if absent.
  Future<NoteModel?> getEncryptedNoteRaw(String id);

  /// Re-stamps keychain material + recomputed hash on a note row.
  Future<void> updateKeychainColumns({
    required String noteId,
    required String encSalt,
    required String encWrappedMkPass,
    String? encWrappedMkRecovery,
    required String hash,
  });
}
