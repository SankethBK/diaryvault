import 'package:dairy_app/features/notes/data/models/notes_model.dart';

abstract class IEncryptedNotesLocalDataSource {
  /// Keychain columns from any encrypted note (fresh-device hydration).
  /// Returns null when no encrypted notes exist.
  Future<Map<String, dynamic>?> fetchKeychainRow();

  /// Every DISTINCT keychain stamped on encrypted note rows. A passphrase
  /// may open several of them (e.g. notes created on another device with
  /// the same passphrase but a keychain generated independently).
  Future<List<Map<String, dynamic>>> fetchDistinctKeychainRows();

  /// All encrypted notes (ciphertext form) with tags and assets.
  Future<List<NoteModel>> fetchEncryptedNotes(String authorId);

  /// Single encrypted note in raw (ciphertext) form, null if absent.
  Future<NoteModel?> getEncryptedNoteRaw(String id);

  /// Re-stamps keychain material + recomputed hash on a note row.
  /// [wrappedDek] is set when the note's DEK is re-wrapped under a
  /// different master key (passphrase change converging foreign notes).
  Future<void> updateKeychainColumns({
    required String noteId,
    required String encSalt,
    required String encWrappedMkPass,
    String? encWrappedMkRecovery,
    String? wrappedDek,
    required String hash,
  });
}
