import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:dairy_app/features/encryption/domain/repositories/key_manager.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/presentation/mixins/note_helper_mixin.dart';
import 'package:dartz/dartz.dart';

final log = printer("EncryptionAwareNotesRepository");

/// Decorates the real notes repository with transparent encryption.
///
/// Read path: encrypted notes are decrypted in memory when the session is
/// unlocked (and cached until lock()); when locked they are returned as
/// placeholders. Write path: notes flagged is_encrypted are encrypted before
/// hitting the database; plaintext is never persisted for them.
///
/// Sync passes decrypt: false to getNote so ciphertext - never plaintext -
/// is uploaded to the cloud.
class EncryptionAwareNotesRepository
    with NoteHelperMixin
    implements INotesRepository {
  final INotesRepository inner;
  final IKeyManager keyManager;
  final CryptoService cryptoService;

  static const String lockedTitle = "🔒 Encrypted note";
  static const String _emptyQuillBody = '[{"insert":"\\n"}]';

  /// Decrypted notes live only here, in memory. Cleared on lock().
  final Map<String, NoteModel> _decryptedCache = {};

  EncryptionAwareNotesRepository({
    required this.inner,
    required this.keyManager,
    required this.cryptoService,
  }) {
    keyManager.state.listen((state) {
      if (state is EncryptionLocked) {
        _decryptedCache.clear();
        log.i("encryption locked, decrypted cache cleared");
      }
    });
  }

  @override
  Future<Either<NotesFailure, NoteModel>> getNote(String id,
      {bool decrypt = true}) async {
    final result = await inner.getNote(id, decrypt: decrypt);
    return result.fold(
      (failure) => Left(failure),
      (note) async {
        if (!note.isEncrypted || !decrypt) return Right(note);
        return Right(await _resolveEncrypted(note));
      },
    );
  }

  @override
  Future<Either<NotesFailure, List<NoteModel>>> fetchNotes(
      {List<String>? noteIds}) async {
    final result = await inner.fetchNotes(noteIds: noteIds);
    return result.fold(
      (failure) => Left(failure),
      (notes) async {
        final resolved =
            await Future.wait(notes.map((n) => _resolveEncrypted(n)));
        return Right(resolved);
      },
    );
  }

  /// Returns the decrypted note (from cache or by decrypting), or a
  /// placeholder when the session is locked.
  Future<NoteModel> _resolveEncrypted(NoteModel note) async {
    if (!note.isEncrypted) return note;

    final cached = _decryptedCache[note.id];
    if (cached != null) return cached;

    if (!keyManager.isUnlocked) return _asLockedPlaceholder(note);

    try {
      final decrypted = await _decryptNote(note);
      _decryptedCache[note.id] = decrypted;
      return decrypted;
    } catch (e) {
      log.e("decryption failed for note ${note.id}: $e");
      return _asLockedPlaceholder(note);
    }
  }

  Future<NoteModel> _decryptNote(NoteModel note) async {
    final masterKey = await keyManager.requireMasterKey();
    final dek = await cryptoService.unwrapKey(
        WrappedKey.fromBase64(note.wrappedDek!), masterKey);
    final fields = await cryptoService.decryptNoteFields(note.body, dek);
    return note.copyWithDecrypted(
      title: fields.title,
      body: fields.body,
      plainText: fields.plainText,
    );
  }

  NoteModel _asLockedPlaceholder(NoteModel note) {
    return note.copyWithDecrypted(
      title: lockedTitle,
      body: _emptyQuillBody,
      plainText: "",
      isLockedPlaceholder: true,
    );
  }

  @override
  Future<Either<NotesFailure, List<NotePreview>>> fetchNotesPreview(
      {String? searchText,
      DateTime? startDate,
      DateTime? endDate,
      List<String>? tags}) async {
    final result = await inner.fetchNotesPreview(
        searchText: searchText,
        startDate: startDate,
        endDate: endDate,
        tags: tags);
    return result.fold(
      (failure) => Left(failure),
      (previews) async {
        if (!keyManager.isUnlocked) {
          // Locked: encrypted previews arrive as placeholders from the DB
          return Right(previews);
        }

        // Unlocked: surface real title/preview text for encrypted notes
        final resolved = await Future.wait(previews.map((preview) async {
          if (!preview.isEncrypted) return preview;
          final note = await _resolveEncryptedById(preview.id);
          if (note == null) return preview;
          return NotePreviewModel(
            id: preview.id,
            createdAt: preview.createdAt,
            title: note.title,
            plainText: note.plainText,
            isEncrypted: true,
          );
        }));
        return Right(resolved);
      },
    );
  }

  Future<NoteModel?> _resolveEncryptedById(String id) async {
    final cached = _decryptedCache[id];
    if (cached != null) return cached;
    final result = await inner.getNote(id);
    return result.fold((_) => null, (note) async {
      if (!note.isEncrypted) return note;
      return await _resolveEncrypted(note);
    });
  }

  @override
  Future<Either<NotesFailure, void>> saveNote(
    Map<String, dynamic> noteMap, {
    bool dontModifyAnyParameters = false,
  }) async {
    // Notes downloaded from cloud are already in their stored (ciphertext)
    // form; never touch them
    if (dontModifyAnyParameters) {
      return inner.saveNote(noteMap, dontModifyAnyParameters: true);
    }

    final prepared = await _prepareForWrite(noteMap);
    return prepared.fold(
      (failure) => Left(failure),
      (preparedMap) => inner.saveNote(preparedMap),
    );
  }

  @override
  Future<Either<NotesFailure, void>> updateNote(
      Map<String, dynamic> noteMap) async {
    final prepared = await _prepareForWrite(noteMap);
    return prepared.fold(
      (failure) => Left(failure),
      (preparedMap) => inner.updateNote(preparedMap),
    );
  }

  /// Encrypts the note map if flagged, or strips encryption leftovers when
  /// the note was decrypted back to a normal note.
  Future<Either<NotesFailure, Map<String, dynamic>>> _prepareForWrite(
      Map<String, dynamic> noteMap) async {
    if (noteMap["is_encrypted"] != 1) {
      // Plain note (or a note being decrypted): force hash recompute and
      // clear any stale encryption material
      noteMap["hash"] = null;
      noteMap["wrapped_dek"] = null;
      noteMap["encryption_version"] = 1;
      noteMap["is_encrypted"] = 0;
      return Right(noteMap);
    }

    if (!keyManager.isUnlocked) {
      log.e("cannot save encrypted note while session is locked");
      return Left(NotesFailure.unknownError(
          "unlock encryption to save this note"));
    }

    try {
      return Right(await _encryptNoteMap(noteMap));
    } catch (e) {
      log.e("encryption of note ${noteMap["id"]} failed: $e");
      return Left(NotesFailure.unknownError());
    }
  }

  Future<Map<String, dynamic>> _encryptNoteMap(
      Map<String, dynamic> noteMap) async {
    final masterKey = await keyManager.requireMasterKey();

    // Reuse the existing DEK on updates (avoids re-wrapping), else generate
    SecretKey dek;
    String wrappedDek;
    final existingWrappedDek = noteMap["wrapped_dek"];
    if (existingWrappedDek != null) {
      dek = await cryptoService.unwrapKey(
          WrappedKey.fromBase64(existingWrappedDek), masterKey);
      wrappedDek = existingWrappedDek;
    } else {
      dek = await cryptoService.generateKey();
      wrappedDek = (await cryptoService.wrapKey(dek, masterKey)).toBase64();
    }

    // Keyed HMAC over the PLAINTEXT, composed identically to the unencrypted
    // hash, so sync change-detection survives re-encryption
    final bodyForHash = replaceAssetPathsByAssetNames(noteMap["body"]);
    final hashInput = noteMap["title"] +
        noteMap["created_at"].toString() +
        bodyForHash +
        (noteMap["tags"] as List).join(",");
    noteMap["hash"] = await cryptoService.contentHmac(hashInput, masterKey);

    final payload = await cryptoService.encryptNoteFields(
      title: noteMap["title"],
      body: noteMap["body"],
      plainText: noteMap["plain_text"] ?? "",
      dek: dek,
    );

    // The ciphertext rides in the existing columns; title/plain_text are
    // placeholders so previews and search never leak content
    noteMap["title"] = lockedTitle;
    noteMap["plain_text"] = null;
    noteMap["body"] = payload;
    noteMap["wrapped_dek"] = wrappedDek;
    noteMap["encryption_version"] = CryptoService.encryptionVersion;
    noteMap["is_encrypted"] = 1;

    // keep the freshly encrypted note readable for this session
    _decryptedCache.remove(noteMap["id"]);

    return noteMap;
  }

  @override
  Future<Either<NotesFailure, void>> deleteNotes(List<String> noteList,
      {bool hardDeletion = false}) async {
    for (final id in noteList) {
      _decryptedCache.remove(id);
    }
    return inner.deleteNotes(noteList, hardDeletion: hardDeletion);
  }

  @override
  Future<Either<NotesFailure, List<String>>> getAllNoteIds() =>
      inner.getAllNoteIds();

  @override
  Future<Either<NotesFailure, List<Map<String, dynamic>>>>
      generateNotesIndex() => inner.generateNotesIndex();

  @override
  String replaceOldAssetPathsWithNewAssetPaths(
          String noteBody, Map<String, dynamic> assetPathMap) =>
      inner.replaceOldAssetPathsWithNewAssetPaths(noteBody, assetPathMap);

  @override
  Future<List<String>> getAllTags() => inner.getAllTags();
}
