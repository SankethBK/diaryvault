import 'package:dairy_app/features/encryption/core/crypto_service.dart';
import 'package:dairy_app/features/encryption/core/crypto_types.dart';
import 'package:dairy_app/features/encryption/data/repositories/encryption_aware_notes_repository.dart';
import 'package:dairy_app/features/encryption/data/repositories/key_manager.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:dartz/dartz.dart';
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
}

/// Stores whatever the decorator hands it, verbatim, so tests can assert on
/// exactly what would have been persisted
class FakeNotesRepository implements INotesRepository {
  final Map<String, Map<String, dynamic>> store = {};

  @override
  Future<Either<NotesFailure, void>> saveNote(Map<String, dynamic> noteMap,
      {bool dontModifyAnyParameters = false}) async {
    store[noteMap["id"]] = Map<String, dynamic>.from(noteMap);
    return const Right(null);
  }

  @override
  Future<Either<NotesFailure, void>> updateNote(
      Map<String, dynamic> noteMap) async {
    final id = noteMap["id"] as String;
    store[id] = {...store[id]!, ...noteMap};
    return const Right(null);
  }

  @override
  Future<Either<NotesFailure, NoteModel>> getNote(String id,
      {bool decrypt = true}) async {
    final map = store[id];
    if (map == null) return Left(NotesFailure.unknownError("not found"));
    return Right(NoteModel.fromJson({
      ...map,
      "asset_dependencies": const <dynamic>[],
      "tags": List<String>.from(map["tags"] ?? []),
    }));
  }

  @override
  Future<Either<NotesFailure, List<NoteModel>>> fetchNotes(
      {List<String>? noteIds}) async {
    final notes = store.entries
        .where((e) => noteIds == null || noteIds.contains(e.key))
        .map((e) => NoteModel.fromJson({
              ...e.value,
              "asset_dependencies": const <dynamic>[],
              "tags": List<String>.from(e.value["tags"] ?? []),
            }))
        .toList();
    return Right(notes);
  }

  @override
  Future<Either<NotesFailure, List<NotePreview>>> fetchNotesPreview(
      {String? searchText,
      DateTime? startDate,
      DateTime? endDate,
      List<String>? tags}) async {
    final previews = store.values
        .map((m) => NotePreviewModel(
              id: m["id"],
              createdAt: DateTime.fromMillisecondsSinceEpoch(m["created_at"]),
              title: m["title"] ?? "",
              plainText: m["plain_text"] ?? "",
              isEncrypted: m["is_encrypted"] == 1,
            ))
        .toList();
    return Right(previews);
  }

  @override
  Future<Either<NotesFailure, void>> deleteNotes(List<String> noteList,
      {bool hardDeletion = false}) async {
    for (final id in noteList) {
      store.remove(id);
    }
    return const Right(null);
  }

  @override
  Future<Either<NotesFailure, List<String>>> getAllNoteIds() async =>
      Right(store.keys.toList());

  @override
  Future<Either<NotesFailure, List<Map<String, dynamic>>>>
      generateNotesIndex() async => Right(store.values.toList());

  @override
  String replaceOldAssetPathsWithNewAssetPaths(
          String noteBody, Map<String, dynamic> assetPathMap) =>
      noteBody;

  @override
  Future<List<String>> getAllTags() async => [];
}

void main() {
  late FakeNotesRepository inner;
  late KeyManager keyManager;
  late EncryptionAwareNotesRepository repo;

  const body = '[{"insert":"Dear diary...\\n"}]';

  Map<String, dynamic> plainNoteMap({bool encrypted = true}) => {
        "id": "n1",
        "created_at": 1700000000000,
        "title": "My secret entry",
        "body": body,
        "plain_text": "Dear diary...",
        "hash": null,
        "last_modified": 1700000001000,
        "deleted": 0,
        "author_id": "user1",
        "asset_dependencies": <NoteAsset>[],
        "tags": <String>["personal"],
        "is_encrypted": encrypted ? 1 : 0,
      };

  Future<NoteModel> getNote(String id, {bool decrypt = true}) async {
    final result = await repo.getNote(id, decrypt: decrypt);
    return result.fold((f) => throw Exception(f.toString()), (n) => n);
  }

  setUp(() async {
    inner = FakeNotesRepository();
    final crypto = TestCryptoService();
    keyManager = KeyManager(
        cryptoService: crypto, keyValueDataSource: InMemoryKeyValueDataSource());
    await keyManager.initialize();
    repo = EncryptionAwareNotesRepository(
        inner: inner, keyManager: keyManager, cryptoService: crypto);
  });

  group("write path", () {
    test("encrypted notes are persisted as ciphertext with placeholders",
        () async {
      await keyManager.setupWithPassphrase("pass");

      await repo.saveNote(plainNoteMap());

      final stored = inner.store["n1"]!;
      expect(stored["title"], EncryptionAwareNotesRepository.lockedTitle);
      expect(stored["plain_text"], isNull);
      expect(stored["body"], isNot(body));
      expect(stored["body"], isNot(contains("Dear diary")));
      expect(stored["wrapped_dek"], isNotNull);
      expect(stored["is_encrypted"], 1);
      expect(stored["hash"], isNotNull);
    });

    test("saving an encrypted note while locked fails and persists nothing",
        () async {
      await keyManager.setupWithPassphrase("pass");
      keyManager.lock();

      final result = await repo.saveNote(plainNoteMap());

      expect(result.isLeft(), isTrue);
      expect(inner.store.containsKey("n1"), isFalse);
    });

    test("saving a plain note clears encryption leftovers", () async {
      await keyManager.setupWithPassphrase("pass");
      await repo.saveNote(plainNoteMap());

      final decrypted = await getNote("n1");
      final decryptBackMap = decrypted.toJson()
        ..["is_encrypted"] = 0
        ..["hash"] = null;

      await repo.updateNote(decryptBackMap);

      final stored = inner.store["n1"]!;
      expect(stored["is_encrypted"], 0);
      expect(stored["wrapped_dek"], isNull);
      expect(stored["hash"], isNull); // inner recomputes its own hash
      expect(stored["body"], body);
    });

    test("sync downloads (dontModifyAnyParameters) pass through untouched",
        () async {
      final cloudNote = plainNoteMap()
        ..["body"] = "base64ciphertext=="
        ..["wrapped_dek"] = "wrappeddek==";

      await repo.saveNote(cloudNote, dontModifyAnyParameters: true);

      expect(inner.store["n1"]!["body"], "base64ciphertext==");
    });

    test("hash is stable across re-encryption of unchanged content", () async {
      await keyManager.setupWithPassphrase("pass");

      await repo.saveNote(plainNoteMap());
      final hash1 = inner.store["n1"]!["hash"];
      final ciphertext1 = inner.store["n1"]!["body"];

      // simulate editor re-saving the same decrypted note
      final decrypted = await getNote("n1");
      await repo.updateNote(decrypted.toJson()..["hash"] = null);
      final hash2 = inner.store["n1"]!["hash"];
      final ciphertext2 = inner.store["n1"]!["body"];

      expect(hash1, hash2); // HMAC over plaintext is deterministic
      expect(ciphertext1, isNot(ciphertext2)); // but IVs differ
    });
  });

  group("read path", () {
    test("unlocked: returns decrypted content", () async {
      await keyManager.setupWithPassphrase("pass");
      await repo.saveNote(plainNoteMap());
      keyManager.lock(); // clear cache
      await keyManager.unlock("pass");

      final note = await getNote("n1");

      expect(note.title, "My secret entry");
      expect(note.body, body);
      expect(note.plainText, "Dear diary...");
      expect(note.isEncrypted, isTrue);
    });

    test("locked: returns a placeholder without plaintext", () async {
      await keyManager.setupWithPassphrase("pass");
      await repo.saveNote(plainNoteMap());
      keyManager.lock();

      final note = await getNote("n1");

      expect(note.title, EncryptionAwareNotesRepository.lockedTitle);
      expect(note.plainText, "");
      expect(note.body, isNot(contains("Dear diary")));
    });

    test("decrypt: false (sync path) returns raw ciphertext", () async {
      await keyManager.setupWithPassphrase("pass");
      await repo.saveNote(plainNoteMap());

      final raw = await getNote("n1", decrypt: false);

      expect(raw.isEncrypted, isTrue);
      expect(raw.body, isNot(contains("Dear diary")));
      expect(raw.title, EncryptionAwareNotesRepository.lockedTitle);
      expect(raw.wrappedDek, isNotNull);
    });

    test("previews show real content when unlocked, placeholders when locked",
        () async {
      await keyManager.setupWithPassphrase("pass");
      await repo.saveNote(plainNoteMap());

      final unlockedPreviews = (await repo.fetchNotesPreview())
          .getOrElse(() => []);
      final unlocked = unlockedPreviews.firstWhere((p) => p.id == "n1");
      expect(unlocked.title, "My secret entry");
      expect(unlocked.plainText, "Dear diary...");

      keyManager.lock();

      final lockedPreviews = (await repo.fetchNotesPreview())
          .getOrElse(() => []);
      final locked = lockedPreviews.firstWhere((p) => p.id == "n1");
      expect(locked.title, EncryptionAwareNotesRepository.lockedTitle);
      expect(locked.plainText, "");
      expect(locked.isEncrypted, isTrue);
    });

    test("locking clears the decrypted cache", () async {
      await keyManager.setupWithPassphrase("pass");
      await repo.saveNote(plainNoteMap());
      await getNote("n1"); // populate cache

      keyManager.lock();

      final note = await getNote("n1");
      expect(note.title, EncryptionAwareNotesRepository.lockedTitle);
    });
  });
}
