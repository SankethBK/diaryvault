import 'dart:convert';

import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:dairy_app/features/encryption/core/encryption_keychain.dart';
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

  /// Extra keychain rows stamped on notes from "other devices"
  final List<Map<String, dynamic>> extraKeychainRows = [];

  @override
  Future<Map<String, dynamic>?> fetchKeychainRow() async => keychainRow;

  @override
  Future<List<Map<String, dynamic>>> fetchDistinctKeychainRows() async => [
        if (keychainRow != null) keychainRow!,
        ...extraKeychainRows,
      ];

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
      String? wrappedDek,
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

    test("unlock opens keychains from other devices sharing the passphrase",
        () async {
      // device A: sets up encryption independently (own salt + master key)
      final kvA = InMemoryKeyValueDataSource();
      final serviceA = EncryptionSessionService(
        cryptoService: TestCryptoService(),
        keyValueDataSource: kvA,
        encryptedNotesLocalDataSource: FakeEncryptedNotesLocalDataSource(),
      );
      await serviceA.initialize();
      await serviceA.enable("shared passphrase");
      final keychainA = serviceA.requireKeychain();
      final mkA = await serviceA.requireMasterKey();

      // device B: also sets up encryption independently, same passphrase
      await service.initialize();
      await service.enable("shared passphrase");
      final mkB = await service.requireMasterKey();
      service.lock();

      // sanity: the two keychains are DIFFERENT despite the same passphrase
      expect(keychainA.wrappedMkPass.toBase64(),
          isNot(service.requireKeychain().wrappedMkPass.toBase64()));

      // a note created on device A syncs to device B, carrying A's keychain
      dataSource.extraKeychainRows.add({
        "enc_salt": keychainA.kdfParams.toJson()["salt"],
        "enc_wrapped_mk_pass": keychainA.wrappedMkPass.toBase64(),
        "enc_wrapped_mk_recovery": keychainA.wrappedMkRecovery.toBase64(),
        "encryption_version": 1,
      });

      final result = await service.unlock("shared passphrase");

      expect(result.isRight(), isTrue);
      // primary master key is still B's own
      expect(await (await service.requireMasterKey()).extractBytes(),
          await mkB.extractBytes());
      // but A's master key is also available for A's notes
      final mkAonB =
          service.masterKeyForKeychain(keychainA.wrappedMkPass.toBase64());
      expect(mkAonB, isNotNull);
      expect(await mkAonB!.extractBytes(), await mkA.extractBytes());
    });

    test(
        "unlock adopts a synced keychain when the cached one does not open "
        "(passphrase changed on another device)", () async {
      // device A: set up, then its keychain as stamped on synced note rows
      final kvA = InMemoryKeyValueDataSource();
      final serviceA = EncryptionSessionService(
        cryptoService: TestCryptoService(),
        keyValueDataSource: kvA,
        encryptedNotesLocalDataSource: FakeEncryptedNotesLocalDataSource(),
      );
      await serviceA.initialize();
      await serviceA.enable("new passphrase");
      final keychainA = serviceA.requireKeychain();
      final mkA = await serviceA.requireMasterKey();

      // device B: set up earlier with the OLD passphrase, then A's notes
      // (stamped with the new keychain) sync down
      await service.initialize();
      await service.enable("old passphrase");
      service.lock();
      dataSource.extraKeychainRows.add({
        "enc_salt": keychainA.kdfParams.toJson()["salt"],
        "enc_wrapped_mk_pass": keychainA.wrappedMkPass.toBase64(),
        "enc_wrapped_mk_recovery": keychainA.wrappedMkRecovery.toBase64(),
        "encryption_version": 1,
      });

      // user enters the NEW passphrase on B: cached keychain doesn't open,
      // but the synced one does, so it becomes the primary
      final result = await service.unlock("new passphrase");

      expect(result.isRight(), isTrue);
      expect(service.requireKeychain().wrappedMkPass.toBase64(),
          keychainA.wrappedMkPass.toBase64());
      expect(await (await service.requireMasterKey()).extractBytes(),
          await mkA.extractBytes());
      // adoption is persisted
      final cached =
          EncryptionKeychain.deserialize(kv.store["encryption_keychain_cache"]!);
      expect(cached.wrappedMkPass.toBase64(),
          keychainA.wrappedMkPass.toBase64());
    });

    test("recovery code unlocks", () async {
      await service.initialize();
      final code = (await service.enable("pass")).getOrElse(() => "");
      service.lock();

      final result = await service.unlockWithRecovery(code);

      expect(result.isRight(), isTrue);
      expect(service.isUnlocked, isTrue);
    });

    test(
        "unlockAdditionalKeychain opens a foreign keychain without changing "
        "the primary keychain", () async {
      // device A's keychain
      final serviceA = EncryptionSessionService(
        cryptoService: TestCryptoService(),
        keyValueDataSource: InMemoryKeyValueDataSource(),
        encryptedNotesLocalDataSource: FakeEncryptedNotesLocalDataSource(),
      );
      await serviceA.initialize();
      await serviceA.enable("other passphrase");
      final keychainA = serviceA.requireKeychain();
      final mkA = await serviceA.requireMasterKey();

      // this device has its own primary keychain
      await service.initialize();
      await service.enable("my passphrase");
      final primaryBefore = service.requireKeychain();
      final mkPrimary = await service.requireMasterKey();

      final result =
          await service.unlockAdditionalKeychain(keychainA, "other passphrase");

      expect(result.isRight(), isTrue);
      // primary keychain + master key unchanged
      expect(service.requireKeychain().wrappedMkPass.toBase64(),
          primaryBefore.wrappedMkPass.toBase64());
      expect(await (await service.requireMasterKey()).extractBytes(),
          await mkPrimary.extractBytes());
      // foreign keychain's master key now available
      final mkAonThis =
          service.masterKeyForKeychain(keychainA.wrappedMkPass.toBase64());
      expect(await mkAonThis!.extractBytes(), await mkA.extractBytes());
    });

    test("unlockAdditionalKeychain rejects a wrong passphrase", () async {
      final serviceA = EncryptionSessionService(
        cryptoService: TestCryptoService(),
        keyValueDataSource: InMemoryKeyValueDataSource(),
        encryptedNotesLocalDataSource: FakeEncryptedNotesLocalDataSource(),
      );
      await serviceA.initialize();
      await serviceA.enable("right");
      final keychainA = serviceA.requireKeychain();

      await service.initialize();
      await service.enable("mine");

      final result =
          await service.unlockAdditionalKeychain(keychainA, "wrong");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.WRONG_PASSPHRASE),
        (_) => fail("should have failed"),
      );
      expect(service.masterKeyForKeychain(keychainA.wrappedMkPass.toBase64()),
          isNull);
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
