import 'package:cryptography/cryptography.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:dairy_app/features/encryption/core/encryption_keychain.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/data/datasources/encrypted_notes_local_data_source_template.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encrypted_notes_repository.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/presentation/mixins/note_helper_mixin.dart';
import 'package:dartz/dartz.dart';

final log = printer("EncryptedNotesRepository");

class EncryptedNotesRepository
    with NoteHelperMixin
    implements IEncryptedNotesRepository {
  final IEncryptedNotesLocalDataSource encryptedNotesLocalDataSource;
  final INotesLocalDataSource notesLocalDataSource;
  final IEncryptionSessionService sessionService;
  final CryptoService cryptoService;
  final AuthSessionBloc authSessionBloc;

  /// Decrypted notes live only here, in memory. Cleared on lock().
  final Map<String, NoteModel> _decryptedCache = {};

  EncryptedNotesRepository({
    required this.encryptedNotesLocalDataSource,
    required this.notesLocalDataSource,
    required this.sessionService,
    required this.cryptoService,
    required this.authSessionBloc,
  }) {
    sessionService.state.listen((state) {
      if (state is EncryptionLocked) {
        _decryptedCache.clear();
        log.i("encryption locked, decrypted cache cleared");
      }
    });
  }

  String get _userId => authSessionBloc.state.user?.id ?? "";

  @override
  Future<Either<EncryptionFailure, List<NotePreviewModel>>>
      fetchEncryptedNotePreviews() async {
    if (!sessionService.isUnlocked) {
      return Left(EncryptionFailure.locked());
    }
    try {
      final notes =
          await encryptedNotesLocalDataSource.fetchEncryptedNotes(_userId);
      final previews = <NotePreviewModel>[];
      for (final note in notes) {
        final decrypted = await _decryptNote(note);
        if (decrypted == null) {
          // keychain not opened by the current passphrase (e.g. note from a
          // device where a different passphrase was used)
          previews.add(NotePreviewModel(
            id: note.id,
            createdAt: note.createdAt,
            title: "🔒 Locked note",
            plainText: "Protected by a different passphrase",
            isEncrypted: true,
          ));
          continue;
        }
        _decryptedCache[note.id] = decrypted;
        previews.add(NotePreviewModel(
          id: note.id,
          createdAt: note.createdAt,
          title: decrypted.title,
          plainText: decrypted.plainText,
          isEncrypted: true,
        ));
      }
      return Right(previews);
    } catch (e) {
      log.e("fetching encrypted note previews failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<EncryptionFailure, NoteModel>> getEncryptedNote(
      String id) async {
    if (!sessionService.isUnlocked) {
      return Left(EncryptionFailure.locked());
    }
    try {
      final cached = _decryptedCache[id];
      if (cached != null) return Right(cached);

      final raw =
          await encryptedNotesLocalDataSource.getEncryptedNoteRaw(id);
      if (raw == null) {
        return Left(EncryptionFailure.unknownError("note not found"));
      }
      final decrypted = await _decryptNote(raw);
      if (decrypted == null) {
        return Left(EncryptionFailure.differentPassphrase());
      }
      _decryptedCache[id] = decrypted;
      return Right(decrypted);
    } catch (e) {
      log.e("fetching encrypted note $id failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  /// Decrypts with the master key of the note's OWN keychain, so notes
  /// created on another device (same passphrase, independently generated
  /// keychain) decrypt transparently after sync. Returns null when the
  /// session did not open the note's keychain.
  Future<NoteModel?> _decryptNote(NoteModel note) async {
    final noteKeychainId = note.encWrappedMkPass;
    final masterKey = noteKeychainId != null
        ? sessionService.masterKeyForKeychain(noteKeychainId)
        : await sessionService.requireMasterKey();
    if (masterKey == null) return null;
    final dek = await cryptoService.unwrapKey(
        WrappedKey.fromBase64(note.wrappedDek!), masterKey);
    final fields = await cryptoService.decryptNoteFields(note.body, dek);
    return note.copyWithContent(
      title: fields.title,
      body: fields.body,
      plainText: fields.plainText,
    );
  }

  @override
  Future<Either<EncryptionFailure, void>> saveEncryptedNote(
      Map<String, dynamic> noteMap) async {
    try {
      final prepared = await _encryptNoteMap(noteMap, isNew: true);
      prepared["author_id"] = _userId;
      await notesLocalDataSource.saveNote(prepared);
      _decryptedCache.remove(noteMap["id"]);
      return const Right(null);
    } catch (e) {
      log.e("saving encrypted note failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<EncryptionFailure, void>> updateEncryptedNote(
      Map<String, dynamic> noteMap) async {
    try {
      final prepared = await _encryptNoteMap(noteMap, isNew: false);
      await notesLocalDataSource.updateNote(prepared, _userId);
      _decryptedCache.remove(noteMap["id"]);
      return const Right(null);
    } catch (e) {
      log.e("updating encrypted note failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  /// Encrypts a plaintext note map. Asset parsing happens on the plaintext
  /// body BEFORE encryption (the shared write paths can't parse ciphertext).
  Future<Map<String, dynamic>> _encryptNoteMap(Map<String, dynamic> noteMap,
      {required bool isNew}) async {
    if (!sessionService.isUnlocked) {
      throw StateError("cannot save encrypted note while session is locked");
    }

    // Trim removed assets (plaintext body) and delete their files
    final usedNoteAssets = parseAssetPaths(noteMap["body"]);
    final allNoteAssets =
        (noteMap["asset_dependencies"] as List).cast<NoteAsset>();
    for (final asset in allNoteAssets) {
      if (!usedNoteAssets.contains(asset.assetPath)) {
        await notesLocalDataSource.deleteFile(asset.assetPath);
      }
    }
    (noteMap["asset_dependencies"] as List)
        .removeWhere((asset) => !usedNoteAssets.contains(asset.assetPath));

    // An existing encrypted note stays on the keychain it was created with
    // (possibly generated on another device); the stored row is the source
    // of truth. New notes use the session's primary keychain.
    final raw = isNew
        ? null
        : await encryptedNotesLocalDataSource
            .getEncryptedNoteRaw(noteMap["id"]);

    SecretKey dek;
    String wrappedDek;
    String encSalt;
    String encWrappedMkPass;
    String encWrappedMkRecovery;
    SecretKey hashKey;

    if (raw?.encWrappedMkPass != null) {
      final masterKey =
          sessionService.masterKeyForKeychain(raw!.encWrappedMkPass!);
      if (masterKey == null) {
        throw StateError(
            "cannot re-encrypt note: its keychain is not unlocked");
      }
      dek = await cryptoService.unwrapKey(
          WrappedKey.fromBase64(raw.wrappedDek!), masterKey);
      wrappedDek = raw.wrappedDek!;
      encSalt = raw.encSalt!;
      encWrappedMkPass = raw.encWrappedMkPass!;
      encWrappedMkRecovery = raw.encWrappedMkRecovery!;
      hashKey = masterKey;
    } else {
      final masterKey = await sessionService.requireMasterKey();
      final keychain = sessionService.requireKeychain();
      final existingWrappedDek = noteMap["wrapped_dek"];
      if (existingWrappedDek != null) {
        dek = await cryptoService.unwrapKey(
            WrappedKey.fromBase64(existingWrappedDek), masterKey);
        wrappedDek = existingWrappedDek;
      } else {
        dek = await cryptoService.generateKey();
        wrappedDek = (await cryptoService.wrapKey(dek, masterKey)).toBase64();
      }
      encSalt = keychain.kdfParams.toJson()["salt"];
      encWrappedMkPass = keychain.wrappedMkPass.toBase64();
      encWrappedMkRecovery = keychain.wrappedMkRecovery.toBase64();
      hashKey = masterKey;
    }

    // Keyed HMAC over plaintext content AND key material: key/passphrase
    // changes alter the hash, so sync propagates them like a normal edit
    noteMap["hash"] = await _computeHash(
      noteMap,
      encSalt: encSalt,
      encWrappedMkPass: encWrappedMkPass,
      encWrappedMkRecovery: encWrappedMkRecovery,
      wrappedDek: wrappedDek,
      masterKey: hashKey,
    );

    final payload = await cryptoService.encryptNoteFields(
      title: noteMap["title"],
      body: noteMap["body"],
      plainText: noteMap["plain_text"] ?? "",
      dek: dek,
    );

    // Ciphertext rides in the body column; title/plain_text stay NULL so
    // nothing sensitive sits at rest
    noteMap["title"] = null;
    noteMap["plain_text"] = null;
    noteMap["body"] = payload;
    noteMap["is_encrypted"] = 1;
    noteMap["encryption_version"] = CryptoService.encryptionVersion;
    noteMap["enc_salt"] = encSalt;
    noteMap["enc_wrapped_mk_pass"] = encWrappedMkPass;
    noteMap["enc_wrapped_mk_recovery"] = encWrappedMkRecovery;
    noteMap["wrapped_dek"] = wrappedDek;

    return noteMap;
  }

  Future<String> _computeHash(
    Map<String, dynamic> noteMap, {
    required String encSalt,
    required String encWrappedMkPass,
    required String encWrappedMkRecovery,
    required String wrappedDek,
    required SecretKey masterKey,
  }) async {
    final bodyForHash = replaceAssetPathsByAssetNames(noteMap["body"]);
    final hashInput = (noteMap["title"] ?? "") +
        noteMap["created_at"].toString() +
        bodyForHash +
        (noteMap["tags"] as List).join(",") +
        "|enc|" +
        encSalt +
        encWrappedMkPass +
        encWrappedMkRecovery +
        wrappedDek;
    return cryptoService.contentHmac(hashInput, masterKey);
  }

  @override
  Future<String?> computeEditorHash({
    required String noteId,
    required String title,
    required String body,
    required DateTime createdAt,
    required List<String> tags,
    String? wrappedDek,
  }) async {
    if (!sessionService.isUnlocked) return null;
    try {
      final noteMap = {
        "title": title,
        "body": body,
        "created_at": createdAt.millisecondsSinceEpoch,
        "tags": tags,
      };

      // Existing note: reproduce the stored hash exactly, using the
      // keychain material on its row (may originate from another device)
      final raw =
          await encryptedNotesLocalDataSource.getEncryptedNoteRaw(noteId);
      if (raw?.encWrappedMkPass != null) {
        final masterKey =
            sessionService.masterKeyForKeychain(raw!.encWrappedMkPass!);
        if (masterKey == null) return null;
        return _computeHash(
          noteMap,
          encSalt: raw.encSalt!,
          encWrappedMkPass: raw.encWrappedMkPass!,
          encWrappedMkRecovery: raw.encWrappedMkRecovery!,
          wrappedDek: raw.wrappedDek!,
          masterKey: masterKey,
        );
      }

      // New note: hash as the primary keychain will store it
      final keychain = sessionService.requireKeychain();
      return _computeHash(
        noteMap,
        encSalt: keychain.kdfParams.toJson()["salt"],
        encWrappedMkPass: keychain.wrappedMkPass.toBase64(),
        encWrappedMkRecovery: keychain.wrappedMkRecovery.toBase64(),
        wrappedDek: wrappedDek ?? "",
        masterKey: await sessionService.requireMasterKey(),
      );
    } catch (e) {
      log.e("computeEditorHash failed for $noteId: $e");
      return null;
    }
  }

  @override
  Future<Either<NotesFailure, void>> deleteEncryptedNotes(
      List<String> noteList,
      {bool hardDeletion = false}) async {
    try {
      for (final noteId in noteList) {
        await notesLocalDataSource.deleteNote(noteId, _userId,
            hardDeletion: hardDeletion);
        _decryptedCache.remove(noteId);
      }
      return const Right(null);
    } catch (e) {
      log.e(e);
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<EncryptionFailure, void>> changePassphrase(
      String oldPassphrase, String newPassphrase) async {
    // verifies the old passphrase and leaves the session unlocked
    final unlockResult = await sessionService.unlock(oldPassphrase);
    if (unlockResult.isLeft()) {
      return Left(EncryptionFailure.wrongPassphrase());
    }

    try {
      final masterKey = await sessionService.requireMasterKey();
      final oldKeychain = sessionService.requireKeychain();

      final newParams = cryptoService.generateKdfParams();
      final newKek = await cryptoService.deriveKek(newPassphrase, newParams);
      final newKeychain = EncryptionKeychain(
        kdfParams: newParams,
        wrappedMkPass: await cryptoService.wrapKey(masterKey, newKek),
        wrappedMkRecovery: oldKeychain.wrappedMkRecovery,
      );

      await _propagateKeychain(oldKeychain, newKeychain, masterKey);
      await sessionService.updateKeychain(newKeychain);
      log.i("encryption passphrase changed");
      return const Right(null);
    } catch (e) {
      log.e("passphrase change failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<EncryptionFailure, String>> regenerateRecoveryCode(
      String passphrase) async {
    final unlockResult = await sessionService.unlock(passphrase);
    if (unlockResult.isLeft()) {
      return Left(EncryptionFailure.wrongPassphrase());
    }

    try {
      final masterKey = await sessionService.requireMasterKey();
      final oldKeychain = sessionService.requireKeychain();

      final newCode = cryptoService.generateRecoveryCode();
      final recoveryKek = await cryptoService.kekFromRecoveryCode(
          newCode, oldKeychain.kdfParams);
      final newKeychain = EncryptionKeychain(
        kdfParams: oldKeychain.kdfParams,
        wrappedMkPass: oldKeychain.wrappedMkPass,
        wrappedMkRecovery: await cryptoService.wrapKey(masterKey, recoveryKek),
      );

      await _propagateKeychain(oldKeychain, newKeychain, masterKey);
      await sessionService.updateKeychain(newKeychain);
      log.i("recovery code regenerated");
      return Right(newCode);
    } catch (e) {
      log.e("recovery code regeneration failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  /// Re-stamps keychain columns on every encrypted note and recomputes
  /// hashes so the change syncs to other devices. Notes stamped with a
  /// foreign keychain (created on another device) have their DEK re-wrapped
  /// under the primary master key, converging everything onto the new
  /// keychain. Notes whose keychain the session didn't open (different
  /// passphrase) are left untouched.
  Future<void> _propagateKeychain(EncryptionKeychain oldKeychain,
      EncryptionKeychain newKeychain, SecretKey masterKey) async {
    final notes =
        await encryptedNotesLocalDataSource.fetchEncryptedNotes(_userId);
    for (final note in notes) {
      final noteMasterKey = note.encWrappedMkPass != null
          ? sessionService.masterKeyForKeychain(note.encWrappedMkPass!)
          : masterKey;
      if (noteMasterKey == null) {
        log.w("skipping note ${note.id} in keychain propagation: "
            "its keychain is not unlocked");
        continue;
      }

      // decrypt with the note's own DEK to rebuild the hash over plaintext
      final dek = await cryptoService.unwrapKey(
          WrappedKey.fromBase64(note.wrappedDek!), noteMasterKey);
      final fields = await cryptoService.decryptNoteFields(note.body, dek);

      // foreign notes converge onto the primary master key
      String newWrappedDek = note.wrappedDek!;
      if (note.encWrappedMkPass != oldKeychain.wrappedMkPass.toBase64()) {
        newWrappedDek =
            (await cryptoService.wrapKey(dek, masterKey)).toBase64();
      }

      final newHash = await _computeHash({
        "title": fields.title,
        "body": fields.body,
        "created_at": note.createdAt.millisecondsSinceEpoch,
        "tags": note.tags,
      },
          encSalt: newKeychain.kdfParams.toJson()["salt"],
          encWrappedMkPass: newKeychain.wrappedMkPass.toBase64(),
          encWrappedMkRecovery: newKeychain.wrappedMkRecovery.toBase64(),
          wrappedDek: newWrappedDek,
          masterKey: masterKey);

      await encryptedNotesLocalDataSource.updateKeychainColumns(
        noteId: note.id,
        encSalt: newKeychain.kdfParams.toJson()["salt"],
        encWrappedMkPass: newKeychain.wrappedMkPass.toBase64(),
        encWrappedMkRecovery: newKeychain.wrappedMkRecovery.toBase64(),
        wrappedDek: newWrappedDek,
        hash: newHash,
      );
      _decryptedCache.remove(note.id);
    }
  }
}
