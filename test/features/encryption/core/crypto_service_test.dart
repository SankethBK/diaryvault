import 'package:cryptography/cryptography.dart';
import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CryptoService crypto;

  // Light params so tests stay fast; production defaults are heavier
  final testParams = KdfParams.generate(
    memory: 1024,
    iterations: 1,
    parallelism: 1,
  );

  setUp(() {
    crypto = CryptoService();
  });

  group("deriveKek", () {
    test("is deterministic for the same passphrase and params", () async {
      final key1 = await crypto.deriveKek("my secret passphrase", testParams);
      final key2 = await crypto.deriveKek("my secret passphrase", testParams);

      expect(await key1.extractBytes(), await key2.extractBytes());
    });

    test("differs for a different passphrase", () async {
      final key1 = await crypto.deriveKek("passphrase one", testParams);
      final key2 = await crypto.deriveKek("passphrase two", testParams);

      expect(await key1.extractBytes(),
          isNot(await key2.extractBytes()));
    });

    test("differs for a different salt", () async {
      final otherParams = KdfParams.generate(
        memory: 1024,
        iterations: 1,
        parallelism: 1,
      );
      final key1 = await crypto.deriveKek("same passphrase", testParams);
      final key2 = await crypto.deriveKek("same passphrase", otherParams);

      expect(await key1.extractBytes(),
          isNot(await key2.extractBytes()));
    });
  });

  group("wrapKey / unwrapKey", () {
    test("round-trips a key", () async {
      final kek = await crypto.deriveKek("passphrase", testParams);
      final masterKey = await crypto.generateKey();

      final wrapped = await crypto.wrapKey(masterKey, kek);
      final unwrapped = await crypto.unwrapKey(wrapped, kek);

      expect(await unwrapped.extractBytes(), await masterKey.extractBytes());
    });

    test("survives base64 serialization (cloud meta round-trip)", () async {
      final kek = await crypto.deriveKek("passphrase", testParams);
      final masterKey = await crypto.generateKey();

      final wrapped = await crypto.wrapKey(masterKey, kek);
      final restored = WrappedKey.fromBase64(wrapped.toBase64());
      final unwrapped = await crypto.unwrapKey(restored, kek);

      expect(await unwrapped.extractBytes(), await masterKey.extractBytes());
    });

    test("throws on wrong passphrase (GCM auth tag failure)", () async {
      final rightKek = await crypto.deriveKek("right", testParams);
      final wrongKek = await crypto.deriveKek("wrong", testParams);
      final masterKey = await crypto.generateKey();

      final wrapped = await crypto.wrapKey(masterKey, rightKek);

      expect(
        () => crypto.unwrapKey(wrapped, wrongKek),
        throwsA(isA<SecretBoxAuthenticationError>()),
      );
    });
  });

  group("encryptNoteFields / decryptNoteFields", () {
    const title = "My secret entry";
    const body = '[{"insert":"Dear diary...\\n"}]';
    const plainText = "Dear diary...";

    test("round-trips note fields", () async {
      final dek = await crypto.generateKey();

      final encrypted = await crypto.encryptNoteFields(
        title: title,
        body: body,
        plainText: plainText,
        dek: dek,
      );
      final decrypted = await crypto.decryptNoteFields(encrypted, dek);

      expect(decrypted.title, title);
      expect(decrypted.body, body);
      expect(decrypted.plainText, plainText);
    });

    test("produces different ciphertext for identical plaintext (random IV)",
        () async {
      final dek = await crypto.generateKey();

      final encrypted1 = await crypto.encryptNoteFields(
          title: title, body: body, plainText: plainText, dek: dek);
      final encrypted2 = await crypto.encryptNoteFields(
          title: title, body: body, plainText: plainText, dek: dek);

      // This is why sync hashes must be computed over plaintext, not ciphertext
      expect(encrypted1, isNot(encrypted2));
    });

    test("throws when decrypting with the wrong key", () async {
      final dek = await crypto.generateKey();
      final wrongDek = await crypto.generateKey();

      final encrypted = await crypto.encryptNoteFields(
          title: title, body: body, plainText: plainText, dek: dek);

      expect(
        () => crypto.decryptNoteFields(encrypted, wrongDek),
        throwsA(isA<SecretBoxAuthenticationError>()),
      );
    });

    test("throws on tampered ciphertext", () async {
      final dek = await crypto.generateKey();

      final encrypted = await crypto.encryptNoteFields(
          title: title, body: body, plainText: plainText, dek: dek);

      // Flip a byte in the middle of the payload
      final bytes = WrappedKey.fromBase64(encrypted).bytes;
      bytes[bytes.length ~/ 2] ^= 0xFF;
      final tampered = WrappedKey(bytes).toBase64();

      expect(
        () => crypto.decryptNoteFields(tampered, dek),
        throwsA(isA<SecretBoxAuthenticationError>()),
      );
    });
  });

  group("contentHmac", () {
    test("is deterministic for the same content and key", () async {
      final masterKey = await crypto.generateKey();

      final hmac1 = await crypto.contentHmac("note content", masterKey);
      final hmac2 = await crypto.contentHmac("note content", masterKey);

      expect(hmac1, hmac2);
    });

    test("changes when content changes", () async {
      final masterKey = await crypto.generateKey();

      final hmac1 = await crypto.contentHmac("content A", masterKey);
      final hmac2 = await crypto.contentHmac("content B", masterKey);

      expect(hmac1, isNot(hmac2));
    });

    test("cannot be computed without the key", () async {
      final masterKey = await crypto.generateKey();
      final otherKey = await crypto.generateKey();

      final hmac1 = await crypto.contentHmac("same content", masterKey);
      final hmac2 = await crypto.contentHmac("same content", otherKey);

      expect(hmac1, isNot(hmac2));
    });
  });

  group("recovery code", () {
    test("generates codes in the expected format", () {
      final code = crypto.generateRecoveryCode();

      expect(
        RegExp(r"^[a-z2-9]{5}(-[a-z2-9]{5}){4}$").hasMatch(code),
        isTrue,
      );
    });

    test("generates unique codes", () {
      final codes = List.generate(100, (_) => crypto.generateRecoveryCode());
      expect(codes.toSet().length, 100);
    });

    test("kekFromRecoveryCode round-trips through key wrapping", () async {
      final code = crypto.generateRecoveryCode();
      final masterKey = await crypto.generateKey();

      final kek = await crypto.kekFromRecoveryCode(code, testParams);
      final wrapped = await crypto.wrapKey(masterKey, kek);

      // Simulate the user typing the code back with different casing/spacing
      final messyInput = code.toUpperCase().replaceAll("-", " ");
      final restoredKek = await crypto.kekFromRecoveryCode(messyInput, testParams);
      final unwrapped = await crypto.unwrapKey(wrapped, restoredKek);

      expect(await unwrapped.extractBytes(), await masterKey.extractBytes());
    });

    test("wrong recovery code fails to unwrap", () async {
      final code = crypto.generateRecoveryCode();
      final otherCode = crypto.generateRecoveryCode();
      final masterKey = await crypto.generateKey();

      final kek = await crypto.kekFromRecoveryCode(code, testParams);
      final wrapped = await crypto.wrapKey(masterKey, kek);

      final wrongKek = await crypto.kekFromRecoveryCode(otherCode, testParams);
      expect(
        () => crypto.unwrapKey(wrapped, wrongKek),
        throwsA(isA<SecretBoxAuthenticationError>()),
      );
    });
  });

  group("KdfParams", () {
    test("JSON round-trips (encryption_meta.json format)", () {
      final json = testParams.toJson();
      final restored = KdfParams.fromJson(json);

      expect(restored.memory, testParams.memory);
      expect(restored.iterations, testParams.iterations);
      expect(restored.parallelism, testParams.parallelism);
      expect(restored.hashLength, testParams.hashLength);
      expect(restored.salt, testParams.salt);
    });
  });
}
