import 'dart:convert';

import 'package:dairy_app/core/databases/db_schemas.dart';

import '../../domain/entities/notes.dart';

class NoteModel extends Note {
  @override
  // ignore: overridden_fields
  final List<NoteAssetModel> assetDependencies;
  const NoteModel({
    required String id,
    required DateTime createdAt,
    required String title,
    required String body,
    required String hash,
    required DateTime lastModified,
    required String plainText,
    required this.assetDependencies,
  }) : super(
          id: id,
          createdAt: createdAt,
          title: title,
          body: body,
          hash: hash,
          lastModified: lastModified,
          plainText: plainText,
          assetDependencies: assetDependencies,
        );

  factory NoteModel.fromJson(Map<String, dynamic> jsonMap) {
    return NoteModel(
      id: jsonMap["id"],
      createdAt: DateTime.tryParse(jsonMap["created_at"])!,
      title: jsonMap["title"],
      body: jsonMap["body"],
      hash: jsonMap["hash"],
      lastModified: DateTime.tryParse(jsonMap["last_modified"])!,
      plainText: jsonMap["plain_text"],
      assetDependencies: jsonMap["asset_dependencies"]
          .map(
            (noteAssetMap) => NoteAssetModel.fromJson(noteAssetMap),
          )
          .toList(),
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
      "delelted": deleted,
      "asset_dependencies": assetDependencies.map((noteAsset) => noteAsset.toJson()).toList();
    };
  }
}

class NoteAssetModel extends NoteAsset {
  NoteAssetModel({
    required String noteId,
    required String assetType,
    required String assetPath,
  }) : super(noteId: noteId, assetType: assetType, assetPath: assetPath);

  factory NoteAssetModel.fromJson(Map<String, String> jsonMap) {
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
      createdAt: jsonMap["created_at"],
      title: jsonMap["title"],
      plainText: jsonMap["plain_text"],
    );
  }
}
