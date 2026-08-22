import 'dart:convert';

import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/data/datasources/encrypted_notes_local_data_source_template.dart';
import 'package:dairy_app/features/encryption/data/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
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

  @override
  KdfParams kdfParamsForVersion(int version, List<int> salt) => KdfParams(
        memory: 1024,
        iterations: 1,
        parallelism: 1,
        hashLength: 32,
        salt: salt,
      );
}

class FakeEncryptedNotesLocalDataSource
    implements IEncryptedNotesLocalDataSource {
  Map<String, dynamic>? keychainRow;

  @override
  Future<Map<String, dynamic>?> fetchKeychainRow() async => keychainRow;

  @override
  Future<List<NoteModel>> fetchEncryptedNotes(String authorId) async => [];

  @override
  Future<NoteModel?> getEncryptedNoteRaw(String id) async => null;

  @override
  Future<void> updateKeychainColumns(
      {required String noteId,
      required String encSalt,
      required String encWrappedMkPass,
      String? encWrappedMkRecovery,
      required String hash}) async {}
}

void main() {
  late EncryptionSessionService service;
  late InMemoryKeyValueDataSource kv;
  late FakeEncryptedNotesLocalDataSource dataSource;

  setUp(() {
    kv = InMemoryKeyValueDataSource();
    dataSource = FakeEncryptedNotesLocalDataSource();
    service = EncryptionSessionService(
      cryptoService: TestCryptoService(),
      keyValueDataSource: kv,
      encryptedNotesLocalDataSource: dataSource,
    );
  });

  group("initialize", () {
    test("is Disabled with no keychain and no encrypted notes", () async {
      await service.initialize();
      expect(service.currentState, isA<EncryptionDisabled>());
      expect(service.isEnabled, isFalse);
    });

    test("is Locked when keychain is cached locally", () async {
      await service.initialize();
      await service.enable("pass");
      service.lock();

      final service2 = EncryptionSessionService(
        cryptoService: TestCryptoService(),
        keyValueDataSource: kv,
        encryptedNotesLocalDataSource: dataSource,
      );
      await service2.initialize();

      expect(service2.currentState, isA<EncryptionLocked>());
    });

    test("hydrates keychain from a synced encrypted note row (fresh device)",
        () async {
      // device 1: set up and grab the keychain columns as they'd appear on a
      // synced note row
      await service.initialize();
      await service.enable("shared passphrase");
      final keychain = service.requireKeychain();
      final syncedRow = {
        "enc_salt": keychain.kdfParams.toJson()["salt"],
        "enc_wrapped_mk_pass": keychain.wrappedMkPass.toBase64(),
        "enc_wrapped_mk_recovery": keychain.wrappedMkRecovery.toBase64(),
        "encryption_version": 1,
      };

      // device 2: empty prefs, keychain only exists on the synced note
      final kv2 = InMemoryKeyValueDataSource();
      final ds2 = FakeEncryptedNotesLocalDataSource()..keychainRow = syncedRow;
      final service2 = EncryptionSessionService(
        cryptoService: TestCryptoService(),
        keyValueDataSource: kv2,
        encryptedNotesLocalDataSource: ds2,
      );
      await service2.initialize();

      expect(service2.currentState, isA<EncryptionLocked>());

      // same passphrase unlocks on device 2 and yields the same master key
      final result = await service2.unlock("shared passphrase");
      expect(result.isRight(), isTrue);

      final mk1 = await service.requireMasterKey();
      final mk2 = await service2.requireMasterKey();
      expect(await mk1.extractBytes(), await mk2.extractBytes());
    });
  });

  group("enable", () {
    test("returns recovery code, unlocks session, persists keychain", () async {
      await service.initialize();

      final result = await service.enable("my passphrase");

      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => ""), isNotEmpty);
      expect(service.isUnlocked, isTrue);
      expect(service.isEnabled, isTrue);
      expect(kv.store["encryption_keychain_cache"], isNotNull);
    });

    test("fails when already set up", () async {
      await service.initialize();
      await service.enable("first");

      final result = await service.enable("second");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.ALREADY_SET_UP),
        (_) => fail("should have failed"),
      );
    });
  });

  group("unlock", () {
    test("correct passphrase unlocks and restores the same master key",
        () async {
      await service.initialize();
      await service.enable("correct horse");
      final mk1 = await service.requireMasterKey();
      service.lock();

      final result = await service.unlock("correct horse");

      expect(result.isRight(), isTrue);
      final mk2 = await service.requireMasterKey();
      expect(await mk1.extractBytes(), await mk2.extractBytes());
    });

    test("wrong passphrase is rejected with WRONG_PASSPHRASE", () async {
      await service.initialize();
      await service.enable("right");
      service.lock();

      final result = await service.unlock("wrong");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.WRONG_PASSPHRASE),
        (_) => fail("should have failed"),
      );
      expect(service.currentState, isA<EncryptionLocked>());
    });

    test("recovery code unlocks", () async {
      await service.initialize();
      final code = (await service.enable("pass")).getOrElse(() => "");
      service.lock();

      final result = await service.unlockWithRecovery(code);

      expect(result.isRight(), isTrue);
      expect(service.isUnlocked, isTrue);
    });

    test("wrong recovery code is rejected", () async {
      await service.initialize();
      await service.enable("pass");
      service.lock();

      final result =
          await service.unlockWithRecovery("aaaaa-bbbbb-ccccc-ddddd-eeeee");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.WRONG_PASSPHRASE),
        (_) => fail("should have failed"),
      );
    });
  });

  group("lock / requireMasterKey", () {
    test("lock drops the master key", () async {
      await service.initialize();
      await service.enable("pass");

      service.lock();

      expect(service.currentState, isA<EncryptionLocked>());
      expect(() => service.requireMasterKey(), throwsStateError);
    });

    test("state stream emits transitions", () async {
      final states = <EncryptionSessionState>[];
      final sub = service.state.listen(states.add);

      await service.initialize();
      await service.enable("pass");
      service.lock();
      await service.unlock("pass");

      await Future.delayed(Duration.zero);
      expect(states, [
        isA<EncryptionDisabled>(),
        isA<EncryptionUnlocked>(),
        isA<EncryptionLocked>(),
        isA<EncryptionUnlocked>(),
      ]);
      await sub.cancel();
    });
  });

  test("keychain round-trips through prefs serialization", () async {
    await service.initialize();
    await service.enable("pass");

    final serialized = kv.store["encryption_keychain_cache"]!;
    final decoded = jsonDecode(serialized);
    expect(decoded["kdf"]["salt"], isNotNull);
    expect(decoded["wrapped_mk_pass"], isNotNull);
    expect(decoded["wrapped_mk_recovery"], isNotNull);
  });
}
