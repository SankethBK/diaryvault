import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/data/repositories/key_manager.dart';
import 'package:dairy_app/features/encryption/domain/repositories/key_manager.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:flutter_test/flutter_test.dart';

class InMemoryKeyValueDataSource implements IKeyValueDataSource {
  final Map<String, String> store = {};

  @override
  String? getValue(String key) => store[key];

  @override
  Future<void> setValue(String key, String value) async {
    store[key] = value;
  }
}

/// Fast KDF params for tests
class TestCryptoService extends CryptoService {
  @override
  KdfParams generateKdfParams({
    int memory = 1024,
    int iterations = 1,
    int parallelism = 1,
  }) =>
      super.generateKdfParams(
        memory: memory,
        iterations: iterations,
        parallelism: parallelism,
      );
}

void main() {
  late KeyManager keyManager;
  late InMemoryKeyValueDataSource kv;

  setUp(() {
    kv = InMemoryKeyValueDataSource();
    keyManager = KeyManager(cryptoService: TestCryptoService(), keyValueDataSource: kv);
  });

  group("initial state", () {
    test("is NotSetUp when no meta is cached", () async {
      await keyManager.initialize();
      expect(keyManager.currentState, isA<EncryptionNotSetUp>());
      expect(keyManager.isUnlocked, isFalse);
    });

    test("is Locked when meta is cached", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("pass");
      keyManager.lock();

      final km2 = KeyManager(cryptoService: TestCryptoService(), keyValueDataSource: kv);
      await km2.initialize();

      expect(km2.currentState, isA<EncryptionLocked>());
    });
  });

  group("setupWithPassphrase", () {
    test("returns a recovery code and unlocks the session", () async {
      await keyManager.initialize();

      final result = await keyManager.setupWithPassphrase("my passphrase");

      expect(result.isRight(), isTrue);
      final recoveryCode = result.getOrElse(() => "");
      expect(recoveryCode, isNotEmpty);
      expect(keyManager.currentState, isA<EncryptionUnlocked>());
      expect(keyManager.isUnlocked, isTrue);
    });

    test("fails if already set up", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("first");

      final result = await keyManager.setupWithPassphrase("second");

      expect(result.isLeft(), isTrue);
      result.fold(
        (f) => expect(f.code, EncryptionFailure.ALREADY_SET_UP),
        (_) => fail("should have failed"),
      );
    });
  });

  group("unlock", () {
    test("unlocks with the correct passphrase after lock()", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("correct horse");
      keyManager.lock();
      expect(keyManager.currentState, isA<EncryptionLocked>());

      final result = await keyManager.unlock("correct horse");

      expect(result.isRight(), isTrue);
      expect(keyManager.currentState, isA<EncryptionUnlocked>());
    });

    test("rejects a wrong passphrase", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("right");
      keyManager.lock();

      final result = await keyManager.unlock("wrong");

      expect(result.isLeft(), isTrue);
      result.fold(
        (f) => expect(f.code, EncryptionFailure.WRONG_PASSPHRASE),
        (_) => fail("should have failed"),
      );
      expect(keyManager.currentState, isA<EncryptionLocked>());
    });

    test("fails when not set up", () async {
      await keyManager.initialize();

      final result = await keyManager.unlock("anything");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.NOT_SET_UP),
        (_) => fail("should have failed"),
      );
    });
  });

  group("unlockWithRecovery", () {
    test("unlocks with the recovery code", () async {
      await keyManager.initialize();
      final setup = await keyManager.setupWithPassphrase("pass");
      final recoveryCode = setup.getOrElse(() => "");
      keyManager.lock();

      final result = await keyManager.unlockWithRecovery(recoveryCode);

      expect(result.isRight(), isTrue);
      expect(keyManager.isUnlocked, isTrue);
    });

    test("rejects a wrong recovery code", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("pass");
      keyManager.lock();

      final result =
          await keyManager.unlockWithRecovery("aaaaa-bbbbb-ccccc-ddddd-eeeee");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.WRONG_PASSPHRASE),
        (_) => fail("should have failed"),
      );
    });
  });

  group("changePassphrase", () {
    test("old passphrase stops working, new one unlocks", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("old pass");
      keyManager.lock();

      final change = await keyManager.changePassphrase("old pass", "new pass");
      expect(change.isRight(), isTrue);

      keyManager.lock();

      final oldAttempt = await keyManager.unlock("old pass");
      expect(oldAttempt.isLeft(), isTrue);

      final newAttempt = await keyManager.unlock("new pass");
      expect(newAttempt.isRight(), isTrue);
    });

    test("recovery code still works after passphrase change", () async {
      await keyManager.initialize();
      final setup = await keyManager.setupWithPassphrase("old pass");
      final recoveryCode = setup.getOrElse(() => "");

      await keyManager.changePassphrase("old pass", "new pass");
      keyManager.lock();

      final result = await keyManager.unlockWithRecovery(recoveryCode);
      expect(result.isRight(), isTrue);
    });

    test("rejects a wrong old passphrase", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("real pass");

      final result =
          await keyManager.changePassphrase("wrong pass", "new pass");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.WRONG_PASSPHRASE),
        (_) => fail("should have failed"),
      );
    });
  });

  group("requireMasterKey", () {
    test("returns the same key across lock/unlock cycles", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("pass");
      final key1 = await keyManager.requireMasterKey();

      keyManager.lock();
      await keyManager.unlock("pass");
      final key2 = await keyManager.requireMasterKey();

      expect(await key1.extractBytes(), await key2.extractBytes());
    });

    test("throws when locked", () async {
      await keyManager.initialize();
      await keyManager.setupWithPassphrase("pass");
      keyManager.lock();

      expect(() => keyManager.requireMasterKey(), throwsStateError);
    });
  });

  group("state stream", () {
    test("emits state transitions", () async {
      final states = <EncryptionSessionState>[];
      final sub = keyManager.state.listen(states.add);

      await keyManager.initialize();
      await keyManager.setupWithPassphrase("pass");
      keyManager.lock();
      await keyManager.unlock("pass");

      await Future.delayed(Duration.zero);
      expect(states, [
        isA<EncryptionNotSetUp>(),
        isA<EncryptionUnlocked>(),
        isA<EncryptionLocked>(),
        isA<EncryptionUnlocked>(),
      ]);
      await sub.cancel();
    });
  });
}
