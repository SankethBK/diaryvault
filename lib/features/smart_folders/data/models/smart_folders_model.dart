import 'dart:convert';

import '../../domain/entities/smart_folders.dart';

class SmartFolderModel extends SmartFolder {
  @override
  final List<String> folder_tags;

  const SmartFolderModel({
    required String folder_id,
    required DateTime createdAt,
    required String folder_name,
    required this.folder_tags,
    String? authorId
  }) : super(
      folder_id: folder_id,
    createdAt: createdAt,
    folder_name: folder_name,
    folder_tags: folder_tags,
    authorId: authorId
  );

  factory SmartFolderModel.fromJson(Map<String, dynamic> jsonMap) {
    return SmartFolderModel(
      folder_id: jsonMap["folder_id"],
      createdAt: DateTime.fromMillisecondsSinceEpoch(jsonMap["created_at"]),
      folder_name: jsonMap["folder_name"],
      folder_tags: List<String>.from(jsonDecode(jsonMap["folder_tags"])) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "folder_id": folder_id,
      "created_at": createdAt.millisecondsSinceEpoch,
      "folder_name": folder_name,
      "folder_tags": jsonEncode(folder_tags)
    };
  }
}
