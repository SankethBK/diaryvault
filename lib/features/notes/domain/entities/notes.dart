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

  factory Note.initializeWithId(String id) {
    return Note(
      id: id,
      createdAt: DateTime.now(),
      title: "",
      body: "",
      hash: "",
      lastModified: DateTime.now(),
      plainText: "",
      assetDependencies: [],
    );
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
