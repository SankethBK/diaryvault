import 'dart:convert';

import '../../domain/entities/notes.dart';

class NoteModel extends Note {
  const NoteModel({
    required String id,
    required DateTime createdAt,
    required String title,
    required String body,
    required String hash,
    required DateTime lastModified,
    required String plainText,
    required List<Map<String, String>> assetDependencies,
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
      createdAt: jsonMap["createdAt"],
      title: jsonMap["title"],
      body: jsonMap["body"],
      hash: jsonMap["hash"],
      lastModified: jsonMap["lastModified"],
      plainText: jsonMap["plainText"],
      assetDependencies: jsonMap["assetDependencies"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt,
      "title": title,
      "body": body,
      "hash": hash,
      "lastModified": lastModified,
      "plainText": plainText,
      "assetDependencies": assetDependencies,
    };
  }
}
