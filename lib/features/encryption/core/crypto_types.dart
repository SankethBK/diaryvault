import 'dart:convert';
import 'dart:math';

/// Parameters for the Argon2id KDF.
///
/// Serialized into encryption_meta.json (stored in the cloud sync folder) so
/// any device can re-derive keys from the passphrase. The salt is NOT secret,
/// it only needs to be consistent across devices.
class KdfParams {
  static const int currentKdfVersion = 1;

  /// Memory cost in KiB (64 MiB default)
  final int memory;
  final int iterations;
  final int parallelism;

  /// Derived key length in bytes
  final int hashLength;
  final List<int> salt;

  const KdfParams({
    required this.memory,
    required this.iterations,
    required this.parallelism,
    required this.hashLength,
    required this.salt,
  });

  factory KdfParams.generate({
    int memory = 65536,
    int iterations = 3,
    int parallelism = 1,
    int hashLength = 32,
    int saltLength = 16,
  }) {
    final random = Random.secure();
    return KdfParams(
      memory: memory,
      iterations: iterations,
      parallelism: parallelism,
      hashLength: hashLength,
      salt: List<int>.generate(saltLength, (_) => random.nextInt(256)),
    );
  }

  /// KDF params are versioned constants; only the salt is stored per note.
  /// A future encryption_version bump can change these without migration.
  factory KdfParams.forVersion(int version, List<int> salt) {
    return KdfParams(
      memory: 65536,
      iterations: 3,
      parallelism: 1,
      hashLength: 32,
      salt: salt,
    );
  }

  Map<String, dynamic> toJson() => {
        "memory": memory,
        "iterations": iterations,
        "parallelism": parallelism,
        "hash_length": hashLength,
        "salt": base64Encode(salt),
      };

  factory KdfParams.fromJson(Map<String, dynamic> json) => KdfParams(
        memory: json["memory"],
        iterations: json["iterations"],
        parallelism: json["parallelism"],
        hashLength: json["hash_length"],
        salt: base64Decode(json["salt"]),
      );
}

/// An AEAD-encrypted key (master key wrapped by a KEK, or a note DEK wrapped
/// by the master key). Stored as base64(nonce || ciphertext || mac).
class WrappedKey {
  final List<int> bytes;

  const WrappedKey(this.bytes);

  String toBase64() => base64Encode(bytes);

  factory WrappedKey.fromBase64(String encoded) =>
      WrappedKey(base64Decode(encoded));
}

/// Decrypted note content fields.
class DecryptedNoteFields {
  final String title;
  final String body;
  final String plainText;

  const DecryptedNoteFields({
    required this.title,
    required this.body,
    required this.plainText,
  });
}
