import 'dart:async';
import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:dairy_app/features/encryption/core/encryption_keychain.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/data/datasources/encrypted_notes_local_data_source_template.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:dartz/dartz.dart';

final log = printer("EncryptionSessionService");

class EncryptionSessionService implements IEncryptionSessionService {
  static const String _keychainCacheKey = "encryption_keychain_cache";

  final CryptoService cryptoService;
  final IKeyValueDataSource keyValueDataSource;
  final IEncryptedNotesLocalDataSource encryptedNotesLocalDataSource;

  final _stateController =
      StreamController<EncryptionSessionState>.broadcast();

  EncryptionSessionState _currentState = EncryptionDisabled();

  /// The primary master key (from the cached keychain). In memory only,
  /// never persisted. Used for encrypting new notes.
  SecretKey? _masterKey;

  /// Master keys for EVERY keychain the current passphrase/recovery code
  /// opened, keyed by the keychain's wrapped-MK-pass blob. Covers notes
  /// synced from another device whose keychain was generated independently
  /// with the same passphrase.
  final Map<String, SecretKey> _masterKeys = {};

  /// Salt + wrapped key blobs. Not secret; cached locally and replicated on
  /// every encrypted note row for sync.
  EncryptionKeychain? _keychain;

  EncryptionSessionService({
    required this.cryptoService,
    required this.keyValueDataSource,
    required this.encryptedNotesLocalDataSource,
  });

  @override
  Stream<EncryptionSessionState> get state => _stateController.stream;

  @override
  EncryptionSessionState get currentState => _currentState;

  @override
  bool get isEnabled => _keychain != null;

  @override
  bool get isUnlocked => _currentState is EncryptionUnlocked;

  void _setState(EncryptionSessionState newState) {
    _currentState = newState;
    _stateController.add(newState);
  }

  @override
  Future<void> initialize() async {
    try {
      final raw = keyValueDataSource.getValue(_keychainCacheKey);
      if (raw != null) {
        _keychain = EncryptionKeychain.deserialize(raw);
        _setState(EncryptionLocked());
        return;
      }

      // Fresh device after sync: hydrate the keychain from any encrypted
      // note row (all encryption material travels at note level)
      final row = await encryptedNotesLocalDataSource.fetchKeychainRow();
      if (row != null &&
          row["enc_salt"] != null &&
          row["enc_wrapped_mk_pass"] != null &&
          row["enc_wrapped_mk_recovery"] != null) {
        _keychain = EncryptionKeychain(
          kdfParams: cryptoService.kdfParamsForVersion(
            row["encryption_version"] ?? 1,
            base64Decode(row["enc_salt"]),
          ),
          wrappedMkPass: WrappedKey.fromBase64(row["enc_wrapped_mk_pass"]),
          wrappedMkRecovery:
              WrappedKey.fromBase64(row["enc_wrapped_mk_recovery"]),
        );
        await keyValueDataSource.setValue(
            _keychainCacheKey, _keychain!.serialize());
        _setState(EncryptionLocked());
        return;
      }

      _setState(EncryptionDisabled());
    } catch (e) {
      log.e("failed to initialize encryption session: $e");
      _setState(EncryptionDisabled());
    }
  }

  @override
  Future<Either<EncryptionFailure, String>> enable(String passphrase) async {
    if (_keychain != null) {
      return Left(EncryptionFailure.alreadySetUp());
    }
    try {
      final masterKey = await cryptoService.generateKey();
      final recoveryCode = cryptoService.generateRecoveryCode();

      final kdfParams = cryptoService.generateKdfParams();
      final passKek = await cryptoService.deriveKek(passphrase, kdfParams);
      final recoveryKek =
          await cryptoService.kekFromRecoveryCode(recoveryCode, kdfParams);

      _keychain = EncryptionKeychain(
        kdfParams: kdfParams,
        wrappedMkPass: await cryptoService.wrapKey(masterKey, passKek),
        wrappedMkRecovery: await cryptoService.wrapKey(masterKey, recoveryKek),
      );
      await keyValueDataSource.setValue(
          _keychainCacheKey, _keychain!.serialize());

      _masterKey = masterKey;
      _masterKeys[_keychain!.wrappedMkPass.toBase64()] = masterKey;
      _setState(EncryptionUnlocked());
      log.i("encryption enabled");
      return Right(recoveryCode);
    } catch (e) {
      log.e("encryption setup failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  /// Every keychain this device knows about: the cached one plus each
  /// distinct keychain stamped on encrypted note rows.
  Future<List<EncryptionKeychain>> _candidateKeychains() async {
    final candidates = <String, EncryptionKeychain>{};
    final cached = _keychain;
    if (cached != null) {
      candidates[cached.wrappedMkPass.toBase64()] = cached;
    }
    for (final row
        in await encryptedNotesLocalDataSource.fetchDistinctKeychainRows()) {
      final keychain = EncryptionKeychain(
        kdfParams: cryptoService.kdfParamsForVersion(
          row["encryption_version"] ?? 1,
          base64Decode(row["enc_salt"]),
        ),
        wrappedMkPass: WrappedKey.fromBase64(row["enc_wrapped_mk_pass"]),
        wrappedMkRecovery:
            WrappedKey.fromBase64(row["enc_wrapped_mk_recovery"]),
      );
      candidates.putIfAbsent(
          keychain.wrappedMkPass.toBase64(), () => keychain);
    }
    return candidates.values.toList();
  }

  /// Tries to open every known keychain with KEKs derived from
  /// [deriveKek]. Caches each master key it opens. Returns false when the
  /// credential opens nothing.
  Future<bool> _unlockKeychains(
      Future<SecretKey> Function(KdfParams) deriveKek,
      WrappedKey Function(EncryptionKeychain) wrappedSlot) async {
    final candidates = await _candidateKeychains();
    if (candidates.isEmpty) return false;

    final opened = <String, SecretKey>{};
    EncryptionKeychain? openedCached;
    EncryptionKeychain? openedOther;
    for (final keychain in candidates) {
      try {
        final kek = await deriveKek(keychain.kdfParams);
        opened[keychain.wrappedMkPass.toBase64()] =
            await cryptoService.unwrapKey(wrappedSlot(keychain), kek);
        if (keychain.wrappedMkPass.toBase64() ==
            _keychain?.wrappedMkPass.toBase64()) {
          openedCached = keychain;
        } else {
          openedOther ??= keychain;
        }
      } on SecretBoxAuthenticationError {
        // this keychain belongs to a different credential; skip it
      }
    }
    if (opened.isEmpty) return false;

    _masterKeys
      ..clear()
      ..addAll(opened);

    // Primary keychain: keep the cached one when it opened. When it didn't
    // (e.g. passphrase was changed on another device and synced here),
    // adopt the synced keychain so future writes match the notes.
    if (openedCached == null && openedOther != null) {
      _keychain = openedOther;
      await keyValueDataSource.setValue(
          _keychainCacheKey, openedOther.serialize());
      log.i("adopted keychain from synced encrypted notes");
    }
    _masterKey = opened[_keychain!.wrappedMkPass.toBase64()];
    _setState(EncryptionUnlocked());
    return true;
  }

  @override
  Future<Either<EncryptionFailure, void>> unlock(String passphrase) async {
    if (_keychain == null &&
        (await encryptedNotesLocalDataSource.fetchDistinctKeychainRows())
            .isEmpty) {
      return Left(EncryptionFailure.notSetUp());
    }

    try {
      final opened = await _unlockKeychains(
        (params) => cryptoService.deriveKek(passphrase, params),
        (keychain) => keychain.wrappedMkPass,
      );
      if (!opened) return Left(EncryptionFailure.wrongPassphrase());
      log.i("encryption session unlocked");
      return const Right(null);
    } catch (e) {
      log.e("unlock failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<EncryptionFailure, void>> unlockWithRecovery(
      String code) async {
    if (_keychain == null &&
        (await encryptedNotesLocalDataSource.fetchDistinctKeychainRows())
            .isEmpty) {
      return Left(EncryptionFailure.notSetUp());
    }

    try {
      final opened = await _unlockKeychains(
        (params) => cryptoService.kekFromRecoveryCode(code, params),
        (keychain) => keychain.wrappedMkRecovery,
      );
      if (!opened) return Left(EncryptionFailure.wrongPassphrase());
      log.i("encryption session unlocked via recovery code");
      return const Right(null);
    } catch (e) {
      log.e("recovery unlock failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  void lock() {
    _masterKey = null;
    _masterKeys.clear();
    _setState(_keychain != null ? EncryptionLocked() : EncryptionDisabled());
    log.i("encryption session locked");
  }

  @override
  Future<SecretKey> requireMasterKey() {
    final key = _masterKey;
    if (key == null) {
      throw StateError("encryption session is locked");
    }
    return Future.value(key);
  }

  @override
  SecretKey? masterKeyForKeychain(String wrappedMkPassB64) =>
      _masterKeys[wrappedMkPassB64];

  @override
  Future<Either<EncryptionFailure, void>> unlockAdditionalKeychain(
      EncryptionKeychain keychain, String passphrase) async {
    try {
      final kek =
          await cryptoService.deriveKek(passphrase, keychain.kdfParams);
      final mk =
          await cryptoService.unwrapKey(keychain.wrappedMkPass, kek);
      _masterKeys[keychain.wrappedMkPass.toBase64()] = mk;
      log.i("additional keychain unlocked");
      return const Right(null);
    } on SecretBoxAuthenticationError {
      return Left(EncryptionFailure.wrongPassphrase());
    } catch (e) {
      log.e("additional keychain unlock failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  EncryptionKeychain requireKeychain() {
    final keychain = _keychain;
    if (keychain == null) {
      throw StateError("encryption is not set up");
    }
    return keychain;
  }

  @override
  Future<void> updateKeychain(EncryptionKeychain keychain) async {
    _keychain = keychain;
    await keyValueDataSource.setValue(_keychainCacheKey, keychain.serialize());
  }
}
