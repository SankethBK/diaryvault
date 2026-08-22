import 'package:dairy_app/core/databases/db_schemas.dart';
import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:sqflite/sqflite.dart';

import 'encrypted_notes_local_data_source_template.dart';

final log = printer("EncryptedNotesLocalDataSource");

/// Read/update queries for encrypted notes only. Writes (insert/update/delete
/// of rows, tags, assets) reuse the regular NotesLocalDataSource, since those
/// paths are column-agnostic; this class exists so the normal notes queries
/// stay untouched.
class EncryptedNotesLocalDataSource implements IEncryptedNotesLocalDataSource {
  static late Database database;

  EncryptedNotesLocalDataSource._();

  static create() async {
    database = await DBProvider.instance.database;
    return EncryptedNotesLocalDataSource._();
  }

  /// Keychain columns from any encrypted note (used to hydrate the keychain
  /// on a fresh device after sync). Returns null when no encrypted notes.
  @override
  Future<Map<String, dynamic>?> fetchKeychainRow() async {
    final result = await database.query(
      Notes.TABLE_NAME,
      columns: [
        Notes.ENC_SALT,
        Notes.ENC_WRAPPED_MK_PASS,
        Notes.ENC_WRAPPED_MK_RECOVERY,
        Notes.ENCRYPTION_VERSION,
      ],
      where:
          "${Notes.IS_ENCRYPTED} = 1 AND ${Notes.DELETED} != 1 AND ${Notes.WRAPPED_DEK} IS NOT NULL",
      limit: 1,
    );
    return result.isEmpty ? null : result.first;
  }

  /// All encrypted notes (ciphertext form) with tags and asset dependencies.
  @override
  Future<List<NoteModel>> fetchEncryptedNotes(String authorId) async {
    List<Map<String, dynamic>> result;
    try {
      result = await database.query(
        Notes.TABLE_NAME,
        where:
            "${Notes.DELETED} != 1 and ${Notes.IS_ENCRYPTED} = 1 and ( ${Notes.AUTHOR_ID} = '$authorId' or ${Notes.AUTHOR_ID} = '${GuestUserDetails.guestUserId}' )",
        orderBy: "${Notes.CREATED_AT} DESC",
      );
    } catch (e) {
      log.e("Local database query for fetching encrypted notes failed $e");
      throw const DatabaseQueryException();
    }

    final List<NoteModel> notes = [];
    for (var note in result) {
      final mutableNote = Map<String, dynamic>.from(note);

      final tagsResult = await database.query(
        Tags.TABLE_NAME,
        where: "${Tags.NOTE_ID} = ?",
        whereArgs: [note[Notes.ID]],
      );
      final tags = tagsResult.map((tag) => tag[Tags.NAME] as String).toList();

      final assetsResult = await database.query(NoteDependencies.TABLE_NAME,
          where: "${NoteDependencies.NOTE_ID} = ?",
          whereArgs: [note[Notes.ID]]);

      notes.add(NoteModel.fromJson({
        ...mutableNote,
        "asset_dependencies": assetsResult,
        "tags": tags,
      }));
    }
    return notes;
  }

  /// Single encrypted note in raw (ciphertext) form.
  @override
  Future<NoteModel?> getEncryptedNoteRaw(String id) async {
    final result = await database.query(
      Notes.TABLE_NAME,
      where: "${Notes.ID} = ? AND ${Notes.IS_ENCRYPTED} = 1",
      whereArgs: [id],
    );
    if (result.isEmpty) return null;

    final note = Map<String, dynamic>.from(result.first);

    final tagsResult = await database.query(
      Tags.TABLE_NAME,
      where: "${Tags.NOTE_ID} = ?",
      whereArgs: [id],
    );
    final tags = tagsResult.map((tag) => tag[Tags.NAME] as String).toList();

    final assetsResult = await database.query(NoteDependencies.TABLE_NAME,
        where: "${NoteDependencies.NOTE_ID} = ?", whereArgs: [id]);

    return NoteModel.fromJson({
      ...note,
      "asset_dependencies": assetsResult,
      "tags": tags,
    });
  }

  /// Stamps new keychain material + recomputed hash onto a note row. Used
  /// when the passphrase changes or the recovery code is rotated: the hash
  /// changes, so sync propagates it like a normal note edit.
  @override
  Future<void> updateKeychainColumns({
    required String noteId,
    required String encSalt,
    required String encWrappedMkPass,
    String? encWrappedMkRecovery,
    required String hash,
  }) async {
    final count = await database.update(
      Notes.TABLE_NAME,
      {
        Notes.ENC_SALT: encSalt,
        Notes.ENC_WRAPPED_MK_PASS: encWrappedMkPass,
        if (encWrappedMkRecovery != null)
          Notes.ENC_WRAPPED_MK_RECOVERY: encWrappedMkRecovery,
        Notes.HASH: hash,
        Notes.LAST_MODIFIED: DateTime.now().millisecondsSinceEpoch,
      },
      where: "${Notes.ID} = ?",
      whereArgs: [noteId],
    );
    if (count != 1) {
      log.e("keychain column update failed for note id: $noteId");
      throw const DatabaseUpdateException();
    }
  }
}
