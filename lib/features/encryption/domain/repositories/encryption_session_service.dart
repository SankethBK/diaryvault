import 'package:cryptography/cryptography.dart';
import 'package:dairy_app/features/encryption/core/encryption_keychain.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dartz/dartz.dart';

sealed class EncryptionSessionState {}

/// Encryption never enabled on this device and no encrypted notes found
class EncryptionDisabled extends EncryptionSessionState {}

/// Keychain exists (locally or via synced encrypted notes) but locked
class EncryptionLocked extends EncryptionSessionState {}

/// Master key in memory; encrypted notes can be read/written
class EncryptionUnlocked extends EncryptionSessionState {}

/// Owns the encryption session. The master key exists ONLY in memory and is
/// dropped on lock() / when leaving the encrypted notes view. The keychain
/// persisted locally holds only salt + AEAD-wrapped blobs (no secrets).
abstract class IEncryptionSessionService {
  Stream<EncryptionSessionState> get state;

  EncryptionSessionState get currentState;

  bool get isEnabled;

  bool get isUnlocked;

  /// Loads the cached keychain, or hydrates it from a synced encrypted note
  /// row (fresh device). Called once at app start.
  Future<void> initialize();

  /// First-time setup. Returns the recovery code to display exactly once.
  Future<Either<EncryptionFailure, String>> enable(String passphrase);

  Future<Either<EncryptionFailure, void>> unlock(String passphrase);

  Future<Either<EncryptionFailure, void>> unlockWithRecovery(String code);

  /// Drops the master key from memory.
  void lock();

  /// Master key for note encrypt/decrypt. Throws [StateError] if locked.
  Future<SecretKey> requireMasterKey();

  /// Keychain material stamped onto every encrypted note row. Throws
  /// [StateError] if encryption was never set up.
  EncryptionKeychain requireKeychain();

  /// Replaces the stored keychain (passphrase change / recovery rotation).
  Future<void> updateKeychain(EncryptionKeychain keychain);
}
