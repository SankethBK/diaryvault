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
  final List<String> tags;
  final bool isEncrypted;
  final int encryptionVersion;

  /// base64(nonce || ciphertext || mac) of the note's DEK wrapped with the
  /// master key. Null for unencrypted notes.
  final String? wrappedDek;

  /// True when this instance is a redacted stand-in for an encrypted note
  /// whose session is locked. Its title/body/plainText are placeholders,
  /// NOT real content - editors must refuse to open it.
  final bool isLockedPlaceholder;

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
    required this.tags,
    this.isEncrypted = false,
    this.encryptionVersion = 1,
    this.wrappedDek,
    this.isLockedPlaceholder = false,
  });

  String getHashingString() {
    // assetDependencies is included in body itself
    return title + createdAt.toString() + body + tags.join(",");
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
      isEncrypted,
      encryptionVersion,
      wrappedDek ?? "",
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
  final bool isEncrypted;

  const NotePreview({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.plainText,
    this.isEncrypted = false,
  });

  @override
  List<Object?> get props => [id];
}
