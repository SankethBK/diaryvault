import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart' as crypto;
import 'package:cryptography/cryptography.dart';

import 'crypto_types.dart';

/// Pure crypto primitives for per-note encryption. Holds no state and does no
/// I/O, so it is testable in isolation.
///
/// Scheme (v1):
///   passphrase/recovery code -> Argon2id -> KEK
///   KEK -> unwraps -> Master Key (random, stored in cloud meta "key slots")
///   Master Key -> unwraps -> per-note DEK (stored with each note)
///   DEK -> AES-256-GCM -> note title/body/plain_text
class CryptoService {
  static const int encryptionVersion = 1;

  static const int _aesGcmNonceLength = 12;
  static const int _aesGcmMacLength = 16;

  // Recovery code alphabet: unambiguous chars only (no 0/o, 1/l/i)
  static const String _recoveryAlphabet = "abcdefghjkmnpqrstuvwxyz23456789";
  static const int recoveryCodeGroupCount = 5;
  static const int recoveryCodeGroupLength = 5;

  // --- KDF ---

  KdfParams generateKdfParams({
    int memory = 65536,
    int iterations = 3,
    int parallelism = 1,
  }) =>
      KdfParams.generate(
        memory: memory,
        iterations: iterations,
        parallelism: parallelism,
      );

  /// KDF params for a stored encryption version. Params are versioned
  /// constants; only the salt travels on note rows.
  KdfParams kdfParamsForVersion(int version, List<int> salt) =>
      KdfParams.forVersion(version, salt);

  /// Derives a Key Encryption Key from a passphrase via Argon2id.
  Future<SecretKey> deriveKek(String passphrase, KdfParams params) {
    final algo = Argon2id(
      memory: params.memory,
      parallelism: params.parallelism,
      iterations: params.iterations,
      hashLength: params.hashLength,
    );
    return algo.deriveKeyFromPassword(
      password: passphrase,
      nonce: params.salt,
    );
  }

  // --- Key generation ---

  /// Generates a random 256-bit key (used for the master key and note DEKs).
  Future<SecretKey> generateKey() => AesGcm.with256bits().newSecretKey();

  // --- Key wrapping (master key <-> KEK, DEK <-> master key) ---

  Future<WrappedKey> wrapKey(SecretKey keyToWrap, SecretKey kek) async {
    final box = await AesGcm.with256bits().encrypt(
      await keyToWrap.extractBytes(),
      secretKey: kek,
    );
    return WrappedKey(box.concatenation());
  }

  /// Throws [SecretBoxAuthenticationError] if [kek] is wrong (i.e. wrong
  /// passphrase) - the GCM auth tag doubles as passphrase verification.
  Future<SecretKey> unwrapKey(WrappedKey wrapped, SecretKey kek) async {
    final box = SecretBox.fromConcatenation(
      wrapped.bytes,
      nonceLength: _aesGcmNonceLength,
      macLength: _aesGcmMacLength,
    );
    final keyBytes =
        await AesGcm.with256bits().decrypt(box, secretKey: kek);
    return SecretKey(keyBytes);
  }

  // --- Note content encryption ---

  /// Encrypts the sensitive note fields into a single base64 payload with one
  /// random IV. The payload is stored in the existing Notes.body column.
  Future<String> encryptNoteFields({
    required String title,
    required String body,
    required String plainText,
    required SecretKey dek,
  }) async {
    final payload = jsonEncode({
      "title": title,
      "body": body,
      "plain_text": plainText,
    });
    final box = await AesGcm.with256bits().encrypt(
      utf8.encode(payload),
      secretKey: dek,
    );
    return base64Encode(box.concatenation());
  }

  /// Throws [SecretBoxAuthenticationError] on tampering or wrong key.
  Future<DecryptedNoteFields> decryptNoteFields(
    String encryptedPayload,
    SecretKey dek,
  ) async {
    final box = SecretBox.fromConcatenation(
      base64Decode(encryptedPayload),
      nonceLength: _aesGcmNonceLength,
      macLength: _aesGcmMacLength,
    );
    final plainBytes =
        await AesGcm.with256bits().decrypt(box, secretKey: dek);
    final json = jsonDecode(utf8.decode(plainBytes));
    return DecryptedNoteFields(
      title: json["title"],
      body: json["body"],
      plainText: json["plain_text"],
    );
  }

  // --- Sync hash ---

  /// Keyed, deterministic content hash (HMAC-SHA256) used as the sync hash
  /// for encrypted notes. Deterministic so change detection survives
  /// re-encryption (random IVs make ciphertext hashing useless); keyed so
  /// the cloud provider can't run confirmation attacks on the plaintext.
  Future<String> contentHmac(String content, SecretKey masterKey) async {
    final hmac = crypto.Hmac(crypto.sha256, await masterKey.extractBytes());
    return hmac.convert(utf8.encode(content)).toString();
  }

  // --- Recovery code ---

  /// Generates a recovery code like "xk2qm-9f3na-pw7ct-hz8dj-r4vbm".
  /// 25 chars from a 31-char alphabet ~= 123 bits of entropy.
  String generateRecoveryCode() {
    final random = Random.secure();
    final groups = List.generate(
      recoveryCodeGroupCount,
      (_) => List.generate(
        recoveryCodeGroupLength,
        (_) => _recoveryAlphabet[random.nextInt(_recoveryAlphabet.length)],
      ).join(),
    );
    return groups.join("-");
  }

  /// Normalizes user input (case/spacing/dash tolerant) and derives the
  /// recovery KEK.
  Future<SecretKey> kekFromRecoveryCode(String code, KdfParams params) {
    final normalized = code.toLowerCase().replaceAll(RegExp(r"[\s-]"), "");
    return deriveKek(normalized, params);
  }
}
