import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/data/datasources/encrypted_notes_local_data_source_template.dart';
import 'package:dairy_app/features/encryption/data/repositories/encrypted_notes_repository.dart';
import 'package:dairy_app/features/encryption/data/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';
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

/// In-memory stand-in for the encrypted-notes read queries
class FakeEncryptedNotesLocalDataSource
    implements IEncryptedNotesLocalDataSource {
  /// Raw (post-encryption) rows, keyed by note id
  final Map<String, Map<String, dynamic>> rows = {};

  @override
  Future<Map<String, dynamic>?> fetchKeychainRow() async {
    if (rows.isEmpty) return null;
    final row = rows.values.first;
    return {
      "enc_salt": row["enc_salt"],
      "enc_wrapped_mk_pass": row["enc_wrapped_mk_pass"],
      "enc_wrapped_mk_recovery": row["enc_wrapped_mk_recovery"],
      "encryption_version": row["encryption_version"],
    };
  }

  @override
  Future<List<NoteModel>> fetchEncryptedNotes(String authorId) async {
    return rows.values
        .map((m) => NoteModel.fromJson({
              ...m,
              "asset_dependencies": const <dynamic>[],
              "tags": List<String>.from(m["tags"] ?? []),
            }))
        .toList();
  }

  @override
  Future<NoteModel?> getEncryptedNoteRaw(String id) async {
    final m = rows[id];
    if (m == null) return null;
    return NoteModel.fromJson({
      ...m,
      "asset_dependencies": const <dynamic>[],
      "tags": List<String>.from(m["tags"] ?? []),
    });
  }

  @override
  Future<void> updateKeychainColumns(
      {required String noteId,
      required String encSalt,
      required String encWrappedMkPass,
      String? encWrappedMkRecovery,
      required String hash}) async {
    rows[noteId] = {
      ...rows[noteId]!,
      "enc_salt": encSalt,
      "enc_wrapped_mk_pass": encWrappedMkPass,
      if (encWrappedMkRecovery != null)
        "enc_wrapped_mk_recovery": encWrappedMkRecovery,
      "hash": hash,
    };
  }
}

/// In-memory stand-in for the shared (write-side) notes data source
class FakeNotesLocalDataSource implements INotesLocalDataSource {
  final FakeEncryptedNotesLocalDataSource encryptedStore;
  final List<String> deletedFiles = [];

  FakeNotesLocalDataSource(this.encryptedStore);

  @override
  Future<void> saveNote(Map<String, dynamic> noteMap) async {
    encryptedStore.rows[noteMap["id"]] = Map<String, dynamic>.from(noteMap);
  }

  @override
  Future<void> updateNote(Map<String, dynamic> noteMap, String authorId) async {
    final id = noteMap["id"] as String;
    encryptedStore.rows[id] = {...encryptedStore.rows[id]!, ...noteMap};
  }

  @override
  Future<void> deleteNote(String id, String authorId,
      {bool hardDeletion = false}) async {
    encryptedStore.rows.remove(id);
  }

  @override
  Future<void> deleteFile(String filePath) async {
    deletedFiles.add(filePath);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError(invocation.memberName.toString());
}

void main() {
  late FakeEncryptedNotesLocalDataSource encryptedDs;
  late FakeNotesLocalDataSource notesDs;
  late EncryptionSessionService sessionService;
  late EncryptedNotesRepository repo;
  late InMemoryKeyValueDataSource kv;

  const body = '[{"insert":"Dear diary...\\n"}]';

  Map<String, dynamic> plainNoteMap() => {
        "id": "n1",
        "created_at": 1700000000000,
        "title": "My secret entry",
        "body": body,
        "plain_text": "Dear diary...",
        "hash": null,
        "last_modified": 1700000001000,
        "deleted": 0,
        "asset_dependencies": <NoteAssetModel>[],
        "tags": <String>["personal"],
        "wrapped_dek": null,
      };

  Future<NoteModel> getNote(String id) async {
    final result = await repo.getEncryptedNote(id);
    return result.fold((f) => throw Exception(f.toString()), (n) => n);
  }

  Future<void> enableEncryption() async {
    await sessionService.initialize();
    await sessionService.enable("test passphrase");
  }

  setUp(() {
    encryptedDs = FakeEncryptedNotesLocalDataSource();
    notesDs = FakeNotesLocalDataSource(encryptedDs);
    kv = InMemoryKeyValueDataSource();
    sessionService = EncryptionSessionService(
      cryptoService: TestCryptoService(),
      keyValueDataSource: kv,
      encryptedNotesLocalDataSource: encryptedDs,
    );
    repo = EncryptedNotesRepository(
      encryptedNotesLocalDataSource: encryptedDs,
      notesLocalDataSource: notesDs,
      sessionService: sessionService,
      cryptoService: TestCryptoService(),
      authSessionBloc: AuthSessionBloc(keyValueDataSource: kv),
    );
  });

  group("write path", () {
    test("saves notes as ciphertext with note-level keychain material",
        () async {
      await enableEncryption();

      await repo.saveEncryptedNote(plainNoteMap());

      final stored = encryptedDs.rows["n1"]!;
      expect(stored["is_encrypted"], 1);
      expect(stored["title"], isNull);
      expect(stored["plain_text"], isNull);
      expect(stored["body"], isNot(contains("Dear diary")));
      expect(stored["enc_salt"], isNotNull);
      expect(stored["enc_wrapped_mk_pass"], isNotNull);
      expect(stored["enc_wrapped_mk_recovery"], isNotNull);
      expect(stored["wrapped_dek"], isNotNull);
      expect(stored["hash"], isNotNull);
    });

    test("saving while locked fails and persists nothing", () async {
      await enableEncryption();
      sessionService.lock();

      final result = await repo.saveEncryptedNote(plainNoteMap());

      expect(result.isLeft(), isTrue);
      expect(encryptedDs.rows.containsKey("n1"), isFalse);
    });

    test("unused assets are trimmed from plaintext and files deleted",
        () async {
      await enableEncryption();

      final bodyWithImage =
          '[{"insert":"look\\n"},{"insert":{"image":"/files/img1.png"}},{"insert":"\\n"}]';
      final noteMap = plainNoteMap()
        ..["body"] = bodyWithImage
        ..["plain_text"] = "look"
        ..["asset_dependencies"] = [
          const NoteAssetModel(
              noteId: "n1", assetType: "image", assetPath: "/files/img1.png"),
          const NoteAssetModel(
              noteId: "n1", assetType: "image", assetPath: "/files/orphan.png"),
        ];

      await repo.saveEncryptedNote(noteMap);

      final stored = encryptedDs.rows["n1"]!;
      final assets = stored["asset_dependencies"] as List;
      expect(assets.length, 1);
      expect(notesDs.deletedFiles, ["/files/orphan.png"]);
      expect(stored["body"], isNot(contains("img1.png")));
    });

    test("hash changes when content changes, stable when unchanged", () async {
      await enableEncryption();

      await repo.saveEncryptedNote(plainNoteMap());
      final hash1 = encryptedDs.rows["n1"]!["hash"];
      final ciphertext1 = encryptedDs.rows["n1"]!["body"];

      // re-save identical content (editor round-trip)
      final note = await getNote("n1");
      await repo.updateEncryptedNote(note.toJson()
        ..addAll({
          "asset_dependencies": <NoteAssetModel>[],
          "wrapped_dek": note.wrappedDek,
        }));

      expect(encryptedDs.rows["n1"]!["hash"], hash1);
      expect(encryptedDs.rows["n1"]!["body"], isNot(ciphertext1));

      // content change -> hash change
      final modified = note.toJson()
        ..addAll({
          "asset_dependencies": <NoteAssetModel>[],
          "wrapped_dek": note.wrappedDek,
        });
      modified["plain_text"] = "changed";
      modified["body"] = '[{"insert":"changed\\n"}]';
      await repo.updateEncryptedNote(modified);

      expect(encryptedDs.rows["n1"]!["hash"], isNot(hash1));
    });
  });

  group("read path", () {
    test("round-trips note content when unlocked", () async {
      await enableEncryption();
      await repo.saveEncryptedNote(plainNoteMap());
      sessionService.lock();
      await sessionService.unlock("test passphrase");

      final note = await getNote("n1");

      expect(note.title, "My secret entry");
      expect(note.body, body);
      expect(note.plainText, "Dear diary...");
      expect(note.isEncrypted, isTrue);
    });

    test("locked session cannot read", () async {
      await enableEncryption();
      await repo.saveEncryptedNote(plainNoteMap());
      sessionService.lock();

      final result = await repo.getEncryptedNote("n1");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.LOCKED),
        (_) => fail("should have failed"),
      );
    });

    test("previews are decrypted when unlocked", () async {
      await enableEncryption();
      await repo.saveEncryptedNote(plainNoteMap());
      sessionService.lock();
      await sessionService.unlock("test passphrase");

      final previews =
          (await repo.fetchEncryptedNotePreviews()).getOrElse(() => []);

      expect(previews.length, 1);
      expect(previews.first.title, "My secret entry");
      expect(previews.first.plainText, "Dear diary...");
      expect(previews.first.isEncrypted, isTrue);
    });

    test("locking clears the decrypted cache", () async {
      await enableEncryption();
      await repo.saveEncryptedNote(plainNoteMap());
      await getNote("n1"); // populate cache

      sessionService.lock();

      final result = await repo.getEncryptedNote("n1");
      expect(result.isLeft(), isTrue);
    });
  });

  group("changePassphrase", () {
    test("re-wraps keychain on notes and hash changes propagate", () async {
      await enableEncryption();
      await repo.saveEncryptedNote(plainNoteMap());
      final oldHash = encryptedDs.rows["n1"]!["hash"];
      final oldSalt = encryptedDs.rows["n1"]!["enc_salt"];

      final result =
          await repo.changePassphrase("test passphrase", "new passphrase");

      expect(result.isRight(), isTrue);
      expect(encryptedDs.rows["n1"]!["enc_salt"], isNot(oldSalt));
      expect(encryptedDs.rows["n1"]!["hash"], isNot(oldHash));

      // old passphrase no longer works, new one does, note still decrypts
      sessionService.lock();
      expect((await sessionService.unlock("test passphrase")).isLeft(),
          isTrue);
      expect((await sessionService.unlock("new passphrase")).isRight(),
          isTrue);

      final note = await getNote("n1");
      expect(note.title, "My secret entry");
    });

    test("rejects wrong old passphrase and changes nothing", () async {
      await enableEncryption();
      await repo.saveEncryptedNote(plainNoteMap());
      final oldHash = encryptedDs.rows["n1"]!["hash"];

      final result = await repo.changePassphrase("wrong", "new");

      result.fold(
        (f) => expect(f.code, EncryptionFailure.WRONG_PASSPHRASE),
        (_) => fail("should have failed"),
      );
      expect(encryptedDs.rows["n1"]!["hash"], oldHash);
    });
  });

  group("regenerateRecoveryCode", () {
    test("new code unlocks, old code does not", () async {
      await sessionService.initialize();
      final firstCode =
          (await sessionService.enable("pass")).getOrElse(() => "");
      await repo.saveEncryptedNote(plainNoteMap());

      final regenResult = await repo.regenerateRecoveryCode("pass");
      expect(regenResult.isRight(), isTrue);
      final newCode = regenResult.getOrElse(() => "");
      expect(newCode, isNot(firstCode));

      sessionService.lock();
      expect((await sessionService.unlockWithRecovery(newCode)).isRight(),
          isTrue);

      sessionService.lock();
      expect((await sessionService.unlockWithRecovery(firstCode)).isLeft(),
          isTrue);
    });
  });
}
