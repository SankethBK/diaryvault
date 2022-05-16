import 'package:equatable/equatable.dart';

class Note extends Equatable {
  String id;
  DateTime createdAt;
  String title;
  String body;
  String hash;
  DateTime lastModified;
  String plainText;
  List<NoteAsset> assetDependencies;
  bool deleted;

  Note({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.body,
    required this.hash,
    required this.lastModified,
    required this.plainText,
    required this.assetDependencies,
    this.deleted = false,
  });

  factory Note.createDummy() {
    return Note(
      id: "",
      createdAt: DateTime.now(),
      title: "",
      body: "",
      hash: "",
      lastModified: DateTime.now(),
      plainText: "",
      assetDependencies: [],
    );
  }

  String getHashingString() {
    // assetDependencies is included in body itself
    return title + createdAt.toString() + body;
  }

  @override
  List<Object?> get props => [id];
}

class NoteAsset extends Equatable {
  final String noteId;
  final String assetType;
  final String assetPath;

  NoteAsset({
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
