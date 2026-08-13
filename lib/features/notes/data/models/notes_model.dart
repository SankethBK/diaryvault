import '../../domain/entities/notes.dart';

class NoteModel extends Note {
  @override
  // ignore: overridden_fields
  final List<NoteAssetModel> assetDependencies;
  @override
  // ignore: overridden_fields
  final List<String> tags;

  const NoteModel({
    required String id,
    required DateTime createdAt,
    required String title,
    required String body,
    required String hash,
    required DateTime lastModified,
    required String plainText,
    String? authorId,
    required this.assetDependencies,
    required this.tags,
    bool isEncrypted = false,
    int encryptionVersion = 1,
    String? wrappedDek,
    bool isLockedPlaceholder = false,
  }) : super(
          id: id,
          createdAt: createdAt,
          title: title,
          body: body,
          hash: hash,
          lastModified: lastModified,
          plainText: plainText,
          assetDependencies: assetDependencies,
          authorId: authorId,
          tags: tags,
          isEncrypted: isEncrypted,
          encryptionVersion: encryptionVersion,
          wrappedDek: wrappedDek,
          isLockedPlaceholder: isLockedPlaceholder,
        );

  factory NoteModel.fromJson(Map<String, dynamic> jsonMap) {
    return NoteModel(
      id: jsonMap["id"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(jsonMap["created_at"]),
      title: jsonMap["title"] ?? "",
      body: jsonMap["body"] ?? "",
      hash: jsonMap["hash"],
      lastModified:
          DateTime.fromMillisecondsSinceEpoch(jsonMap["last_modified"]),
      plainText: jsonMap["plain_text"] ?? "",
      assetDependencies: jsonMap["asset_dependencies"] != null
          ? jsonMap["asset_dependencies"]
              .map<NoteAssetModel>(
                (noteAssetMap) => NoteAssetModel.fromJson(noteAssetMap),
              )
              .toList()
          : [],
      tags: jsonMap["tags"] ?? [],
      isEncrypted: jsonMap["is_encrypted"] == 1 || jsonMap["is_encrypted"] == true,
      encryptionVersion: jsonMap["encryption_version"] ?? 1,
      wrappedDek: jsonMap["wrapped_dek"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "created_at": createdAt.millisecondsSinceEpoch,
      "title": title,
      "body": body,
      "hash": hash,
      "last_modified": lastModified.millisecondsSinceEpoch,
      "plain_text": plainText,
      "deleted": deleted ? 1 : 0,
      "asset_dependencies":
          assetDependencies.map((noteAsset) => noteAsset.toJson()).toList(),
      "tags": tags,
      "is_encrypted": isEncrypted ? 1 : 0,
      "encryption_version": encryptionVersion,
      "wrapped_dek": wrappedDek,
    };
  }

  /// Copy with decrypted content after the encryption layer unlocks a note.
  /// Also used to build locked placeholders, with isLockedPlaceholder = true.
  NoteModel copyWithDecrypted({
    required String title,
    required String body,
    required String plainText,
    bool isLockedPlaceholder = false,
  }) {
    return NoteModel(
      id: id,
      createdAt: createdAt,
      title: title,
      body: body,
      hash: hash,
      lastModified: lastModified,
      plainText: plainText,
      authorId: authorId,
      assetDependencies: assetDependencies,
      tags: tags,
      isEncrypted: isEncrypted,
      encryptionVersion: encryptionVersion,
      wrappedDek: wrappedDek,
      isLockedPlaceholder: isLockedPlaceholder,
    );
  }
}

class NoteAssetModel extends NoteAsset {
  const NoteAssetModel({
    required String noteId,
    required String assetType,
    required String assetPath,
  }) : super(noteId: noteId, assetType: assetType, assetPath: assetPath);

  factory NoteAssetModel.fromJson(Map<String, dynamic> jsonMap) {
    return NoteAssetModel(
      noteId: jsonMap["note_id"]!,
      assetType: jsonMap["asset_type"]!,
      assetPath: jsonMap["asset_path"]!,
    );
  }

  Map<String, String> toJson() {
    return {
      "note_id": noteId,
      "asset_type": assetType,
      "asset_path": assetPath,
    };
  }
}

class NotePreviewModel extends NotePreview {
  const NotePreviewModel({
    required String id,
    required DateTime createdAt,
    required String title,
    required String plainText,
    bool isEncrypted = false,
  }) : super(
            id: id,
            createdAt: createdAt,
            title: title,
            plainText: plainText,
            isEncrypted: isEncrypted);

  factory NotePreviewModel.fromJson(Map<String, dynamic> jsonMap) {
    return NotePreviewModel(
      id: jsonMap["id"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(jsonMap["created_at"]),
      title: jsonMap["title"] ?? "",
      plainText: jsonMap["plain_text"] ?? "",
      isEncrypted:
          jsonMap["is_encrypted"] == 1 || jsonMap["is_encrypted"] == true,
    );
  }
}
