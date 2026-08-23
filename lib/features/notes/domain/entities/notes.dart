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

  // Encryption fields (null/absent for normal notes)
  final bool isEncrypted;
  final int encryptionVersion;
  final String? encSalt;
  final String? encWrappedMkPass;
  final String? encWrappedMkRecovery;
  final String? wrappedDek;

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
    this.encSalt,
    this.encWrappedMkPass,
    this.encWrappedMkRecovery,
    this.wrappedDek,
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

  /// The note's keychain was not opened by the current session (e.g. it was
  /// created on another device with a different passphrase)
  final bool isLocked;

  const NotePreview({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.plainText,
    this.isEncrypted = false,
    this.isLocked = false,
  });

  @override
  List<Object?> get props => [id];
}
