import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dartz/dartz.dart';

/// CRUD for encrypted notes. Completely separate from the normal notes
/// repository so the unencrypted code path is untouched. All methods that
/// read or write content require an unlocked encryption session.
abstract class IEncryptedNotesRepository {
  /// Decrypted previews for the encrypted notes view
  Future<Either<EncryptionFailure, List<NotePreviewModel>>>
      fetchEncryptedNotePreviews();

  /// Full decrypted note for the editor/reader
  Future<Either<EncryptionFailure, NoteModel>> getEncryptedNote(String id);

  /// [noteMap] holds PLAINTEXT title/body/plain_text; it is encrypted before
  /// persisting. Never stores plaintext for encrypted notes.
  Future<Either<EncryptionFailure, void>> saveEncryptedNote(
      Map<String, dynamic> noteMap);

  Future<Either<EncryptionFailure, void>> updateEncryptedNote(
      Map<String, dynamic> noteMap);

  Future<Either<NotesFailure, void>> deleteEncryptedNotes(
      List<String> noteList,
      {bool hardDeletion = false});

  /// Verifies [oldPassphrase], derives a new keychain and re-wraps every
  /// encrypted note's passphrase slot. Hashes change, so sync propagates.
  Future<Either<EncryptionFailure, void>> changePassphrase(
      String oldPassphrase, String newPassphrase);

  /// Rotates the recovery code and re-wraps every encrypted note's recovery
  /// slot. Returns the new recovery code to display exactly once.
  Future<Either<EncryptionFailure, String>> regenerateRecoveryCode(
      String passphrase);

  /// Hash of a note's current editor content, matching the stored hash
  /// composition (used for the close-dialog dirty check). Uses the keychain
  /// the note's row is stamped with, which may differ from the session's
  /// primary keychain for notes created on another device. Returns null
  /// when it can't be computed (locked session / unopened keychain);
  /// callers then fall back to the stored hash.
  Future<String?> computeEditorHash({
    required String noteId,
    required String title,
    required String body,
    required DateTime createdAt,
    required List<String> tags,
    String? wrappedDek,
  });

  /// Opens the keychain stamped on [noteId]'s row using [passphrase],
  /// without changing the session's primary keychain. After this succeeds,
  /// [getEncryptedNote] can decrypt the note. Used for notes protected by a
  /// different passphrase (e.g. set on another device).
  Future<Either<EncryptionFailure, void>> unlockNote(
      String noteId, String passphrase);
}
