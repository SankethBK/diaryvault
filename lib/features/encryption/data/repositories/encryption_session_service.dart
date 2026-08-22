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

  /// The master key. In memory only, never persisted.
  SecretKey? _masterKey;

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
      _setState(EncryptionUnlocked());
      log.i("encryption enabled");
      return Right(recoveryCode);
    } catch (e) {
      log.e("encryption setup failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<EncryptionFailure, void>> unlock(String passphrase) async {
    final keychain = _keychain;
    if (keychain == null) return Left(EncryptionFailure.notSetUp());

    try {
      final kek =
          await cryptoService.deriveKek(passphrase, keychain.kdfParams);
      _masterKey =
          await cryptoService.unwrapKey(keychain.wrappedMkPass, kek);
      _setState(EncryptionUnlocked());
      log.i("encryption session unlocked");
      return const Right(null);
    } on SecretBoxAuthenticationError {
      return Left(EncryptionFailure.wrongPassphrase());
    } catch (e) {
      log.e("unlock failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<EncryptionFailure, void>> unlockWithRecovery(
      String code) async {
    final keychain = _keychain;
    if (keychain == null) return Left(EncryptionFailure.notSetUp());

    try {
      final kek =
          await cryptoService.kekFromRecoveryCode(code, keychain.kdfParams);
      _masterKey =
          await cryptoService.unwrapKey(keychain.wrappedMkRecovery, kek);
      _setState(EncryptionUnlocked());
      log.i("encryption session unlocked via recovery code");
      return const Right(null);
    } on SecretBoxAuthenticationError {
      return Left(EncryptionFailure.wrongPassphrase());
    } catch (e) {
      log.e("recovery unlock failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  void lock() {
    _masterKey = null;
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
