import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/encryption_meta.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/domain/repositories/key_manager.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:dartz/dartz.dart';

final log = printer("KeyManager");

class KeyManager implements IKeyManager {
  static const String _metaCacheKey = "encryption_meta_cache";

  final CryptoService cryptoService;
  final IKeyValueDataSource keyValueDataSource;

  final _stateController =
      StreamController<EncryptionSessionState>.broadcast();

  EncryptionSessionState _currentState = EncryptionNotSetUp();

  /// The master key. In memory only, never persisted.
  SecretKey? _masterKey;

  EncryptionMeta? _meta;

  KeyManager({required this.cryptoService, required this.keyValueDataSource});

  @override
  Stream<EncryptionSessionState> get state => _stateController.stream;

  @override
  EncryptionSessionState get currentState => _currentState;

  @override
  bool get isUnlocked => _currentState is EncryptionUnlocked;

  void _setState(EncryptionSessionState newState) {
    _currentState = newState;
    _stateController.add(newState);
  }

  @override
  Future<void> initialize() async {
    try {
      final raw = keyValueDataSource.getValue(_metaCacheKey);
      if (raw == null) {
        _setState(EncryptionNotSetUp());
        return;
      }
      _meta = EncryptionMeta.deserialize(raw);
      _setState(EncryptionLocked());
    } catch (e) {
      log.e("failed to load encryption meta: $e");
      _setState(EncryptionNotSetUp());
    }
  }

  @override
  Future<Either<EncryptionFailure, String>> setupWithPassphrase(
      String passphrase) async {
    if (_currentState is! EncryptionNotSetUp) {
      return Left(EncryptionFailure.alreadySetUp());
    }
    try {
      final masterKey = await cryptoService.generateKey();
      final recoveryCode = cryptoService.generateRecoveryCode();

      final passphraseParams = cryptoService.generateKdfParams();
      final passphraseKek =
          await cryptoService.deriveKek(passphrase, passphraseParams);

      final recoveryParams = cryptoService.generateKdfParams();
      final recoveryKek =
          await cryptoService.kekFromRecoveryCode(recoveryCode, recoveryParams);

      final keyCheck = await cryptoService.encryptNoteFields(
        title: EncryptionMeta.keyCheckPlaintext,
        body: "",
        plainText: "",
        dek: masterKey,
      );

      _meta = EncryptionMeta(
        version: EncryptionMeta.currentVersion,
        passphraseSlot: KeySlot(
          kdfParams: passphraseParams,
          wrappedMasterKey:
              await cryptoService.wrapKey(masterKey, passphraseKek),
        ),
        recoverySlot: KeySlot(
          kdfParams: recoveryParams,
          wrappedMasterKey: await cryptoService.wrapKey(masterKey, recoveryKek),
        ),
        keyCheck: keyCheck,
      );

      await _persistMeta();
      _masterKey = masterKey;
      _setState(EncryptionUnlocked());
      log.i("encryption set up successfully");
      return Right(recoveryCode);
    } catch (e) {
      log.e("encryption setup failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  Future<Either<EncryptionFailure, void>> unlock(String passphrase) async {
    final meta = _meta;
    if (meta == null) return Left(EncryptionFailure.notSetUp());

    try {
      final kek =
          await cryptoService.deriveKek(passphrase, meta.passphraseSlot.kdfParams);
      return await _unlockWithKek(kek, meta.passphraseSlot, meta);
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
    final meta = _meta;
    if (meta == null) return Left(EncryptionFailure.notSetUp());
    if (meta.recoverySlot == null) {
      return Left(EncryptionFailure.unknownError("no recovery code was set"));
    }

    try {
      final kek = await cryptoService.kekFromRecoveryCode(
          code, meta.recoverySlot!.kdfParams);
      return await _unlockWithKek(kek, meta.recoverySlot!, meta);
    } on SecretBoxAuthenticationError {
      return Left(EncryptionFailure.wrongPassphrase());
    } catch (e) {
      log.e("recovery unlock failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  Future<Either<EncryptionFailure, void>> _unlockWithKek(
      SecretKey kek, KeySlot slot, EncryptionMeta meta) async {
    final masterKey =
        await cryptoService.unwrapKey(slot.wrappedMasterKey, kek);

    // sanity check: decrypt key_check to distinguish wrong passphrase from
    // corrupted metadata (unwrap already authenticates via GCM, this is
    // defense-in-depth)
    final check =
        await cryptoService.decryptNoteFields(meta.keyCheck, masterKey);
    if (check.title != EncryptionMeta.keyCheckPlaintext) {
      return Left(EncryptionFailure.metaCorrupted());
    }

    _masterKey = masterKey;
    _setState(EncryptionUnlocked());
    log.i("encryption session unlocked");
    return const Right(null);
  }

  @override
  Future<Either<EncryptionFailure, void>> changePassphrase(
      String oldPassphrase, String newPassphrase) async {
    final meta = _meta;
    if (meta == null) return Left(EncryptionFailure.notSetUp());

    try {
      // verify old passphrase by unwrapping
      final oldKek = await cryptoService.deriveKek(
          oldPassphrase, meta.passphraseSlot.kdfParams);
      final masterKey =
          await cryptoService.unwrapKey(meta.passphraseSlot.wrappedMasterKey, oldKek);

      // re-wrap only the passphrase slot; master key and notes untouched
      final newParams = cryptoService.generateKdfParams();
      final newKek = await cryptoService.deriveKek(newPassphrase, newParams);

      _meta = EncryptionMeta(
        version: meta.version,
        passphraseSlot: KeySlot(
          kdfParams: newParams,
          wrappedMasterKey: await cryptoService.wrapKey(masterKey, newKek),
        ),
        recoverySlot: meta.recoverySlot,
        keyCheck: meta.keyCheck,
      );
      await _persistMeta();

      _masterKey = masterKey;
      _setState(EncryptionUnlocked());
      log.i("passphrase changed successfully");
      return const Right(null);
    } on SecretBoxAuthenticationError {
      return Left(EncryptionFailure.wrongPassphrase());
    } catch (e) {
      log.e("passphrase change failed: $e");
      return Left(EncryptionFailure.unknownError(e.toString()));
    }
  }

  @override
  void lock() {
    _masterKey = null;
    if (_meta != null) {
      _setState(EncryptionLocked());
    } else {
      _setState(EncryptionNotSetUp());
    }
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

  Future<void> _persistMeta() async {
    // TODO(sync): also upload encryption_meta.json to the cloud sync folder
    // so other devices can unlock with the same passphrase
    await keyValueDataSource.setValue(_metaCacheKey, _meta!.serialize());
  }

  /// Exposed for tests and for the sync layer to import metadata downloaded
  /// from the cloud folder on a fresh device.
  Future<void> importMeta(EncryptionMeta meta) async {
    _meta = meta;
    await _persistMeta();
    _setState(EncryptionLocked());
  }
}
