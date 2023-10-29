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
        );

  factory NoteModel.fromJson(Map<String, dynamic> jsonMap) {
    return NoteModel(
      id: jsonMap["id"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(jsonMap["created_at"]),
      title: jsonMap["title"],
      body: jsonMap["body"],
      hash: jsonMap["hash"],
      lastModified:
          DateTime.fromMillisecondsSinceEpoch(jsonMap["last_modified"]),
      plainText: jsonMap["plain_text"],
      assetDependencies: jsonMap["asset_dependencies"]
          .map<NoteAssetModel>(
            (noteAssetMap) => NoteAssetModel.fromJson(noteAssetMap),
          )
          .toList(),
      tags: jsonMap["tags"] ?? [],
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
      "tags": tags
    };
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
  }) : super(id: id, createdAt: createdAt, title: title, plainText: plainText);

  factory NotePreviewModel.fromJson(Map<String, dynamic> jsonMap) {
    return NotePreviewModel(
      id: jsonMap["id"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(jsonMap["created_at"]),
      title: jsonMap["title"],
      plainText: jsonMap["plain_text"],
    );
  }
}
