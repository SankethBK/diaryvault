import 'package:cryptography/cryptography.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dartz/dartz.dart';

sealed class EncryptionSessionState {}

/// No encryption metadata found - user never enabled encryption
class EncryptionNotSetUp extends EncryptionSessionState {}

/// Encryption is set up but the master key is not in memory
class EncryptionLocked extends EncryptionSessionState {}

/// Master key is in memory; encrypted notes can be read/written
class EncryptionUnlocked extends EncryptionSessionState {}

/// Owns the encryption session. The master key exists ONLY in memory here,
/// never persisted. Encryption metadata (KDF params, wrapped key slots) is
/// synced via the cloud folder and cached locally; it is not tied to any
/// user identity.
abstract class IKeyManager {
  Stream<EncryptionSessionState> get state;

  EncryptionSessionState get currentState;

  bool get isUnlocked;

  /// Loads cached metadata to determine the initial state
  /// (NotSetUp vs Locked). Called once at app start.
  Future<void> initialize();

  /// First-time setup: generates master key, wraps it under passphrase and
  /// recovery code slots, persists metadata.
  ///
  /// Returns the recovery code to display to the user exactly once.
  Future<Either<EncryptionFailure, String>> setupWithPassphrase(
      String passphrase);

  /// Derives the KEK from [passphrase] and unwraps the master key.
  /// Fails with [EncryptionFailure.wrongPassphrase] on a bad passphrase.
  Future<Either<EncryptionFailure, void>> unlock(String passphrase);

  /// Unlocks using the recovery code instead of the passphrase.
  Future<Either<EncryptionFailure, void>> unlockWithRecovery(String code);

  /// Re-wraps the passphrase slot with a new passphrase. The master key and
  /// all note content stay untouched.
  Future<Either<EncryptionFailure, void>> changePassphrase(
      String oldPassphrase, String newPassphrase);

  /// Drops all key material from memory.
  void lock();

  /// Master key for note encrypt/decrypt. Throws [StateError] if locked.
  Future<SecretKey> requireMasterKey();
}
