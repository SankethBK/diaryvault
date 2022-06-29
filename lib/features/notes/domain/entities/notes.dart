import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final DateTime createdAt;
  final String title;
  final String body;
  final String hash;
  final DateTime lastModified;
  final String plainText;
  final List<NoteAsset> assetDependencies;
  final bool deleted;
  final String? authorId;

  const Note({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.hash,
    required this.lastModified,
    required this.plainText,
    required this.assetDependencies,
    this.deleted = false,
    this.authorId,
  });

  String getHashingString() {
    // assetDependencies is included in body itself
    return title + createdAt.toString() + body;
  }

  @override
  List<Object> get props {
    return [
      id,
      createdAt,
      title,
      body,
      hash,
      lastModified,
      plainText,
      assetDependencies,
      deleted,
    ];
  }

  @override
  String toString() {
    return 'Note(id: $id, createdAt: $createdAt, title: $title, body: $body, hash: $hash, lastModified: $lastModified, plainText: $plainText, assetDependencies: $assetDependencies, deleted: $deleted, authorId: $authorId)';
  }
}

class NoteAsset extends Equatable {
  final String noteId;
  final String assetType;
  final String assetPath;

  const NoteAsset({
    required this.noteId,
    required this.assetType,
    required this.assetPath,
  });

  @override
  List<Object?> get props => [noteId, assetType, assetPath];
}

class NotePreview extends Equatable {
  final String id;
  final DateTime createdAt;
  final String title;
  final String plainText;

  const NotePreview({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.plainText,
  });

  @override
  List<Object?> get props => [id];
}
