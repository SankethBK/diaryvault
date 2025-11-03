import 'dart:convert';

import 'package:equatable/equatable.dart';

class SmartFolder extends Equatable {
  final String folder_id;
  final DateTime createdAt;
  final String folder_name;
  final List<String> folder_tags;
  final String? authorId;

  const SmartFolder({
    required this.folder_id,
    required this.createdAt,
    required this.folder_name,
    required this.folder_tags,
    this.authorId
  });

  String getHashingString() {
    return folder_name + createdAt.toString() + folder_tags.join(",");
  }

  @override
  List<Object> get props {
    return [
      folder_id,
      createdAt,
      folder_name,
      folder_tags
    ];
  }

  @override
  String toString() {
    return 'SmartFolder(folder_id: $folder_id, createdAt: $createdAt, folder_name: $folder_name, folder_tags: ' + jsonEncode(folder_tags) + ', authorId: $authorId))';
  }
}
