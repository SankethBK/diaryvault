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

  /// Unlocks with the passphrase. Tries EVERY keychain found locally (the
  /// cached one plus any stamped on synced encrypted note rows) and caches
  /// each master key it opens, so notes created on another device with the
  /// same passphrase decrypt transparently.
  Future<Either<EncryptionFailure, void>> unlock(String passphrase);

  Future<Either<EncryptionFailure, void>> unlockWithRecovery(String code);

  /// Opens an ADDITIONAL keychain with its own passphrase, without changing
  /// the session's primary keychain. Used to read individual notes that
  /// were protected with a different passphrase (e.g. on another device).
  Future<Either<EncryptionFailure, void>> unlockAdditionalKeychain(
      EncryptionKeychain keychain, String passphrase);

  /// Drops the master key from memory.
  void lock();

  /// Primary master key for encrypting new notes. Throws [StateError] if
  /// locked.
  Future<SecretKey> requireMasterKey();

  /// Master key for the keychain identified by its wrapped-MK-pass blob
  /// (the keychain stamped on a note row), or null if the current session
  /// did not open that keychain (e.g. note protected by a different
  /// passphrase).
  SecretKey? masterKeyForKeychain(String wrappedMkPassB64);

  /// Keychain material stamped onto every encrypted note row. Throws
  /// [StateError] if encryption was never set up.
  EncryptionKeychain requireKeychain();

  /// Replaces the stored keychain (passphrase change / recovery rotation).
  Future<void> updateKeychain(EncryptionKeychain keychain);
}
