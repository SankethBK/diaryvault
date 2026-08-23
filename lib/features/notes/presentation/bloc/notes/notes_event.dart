part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class InitializeNote extends NotesEvent {
  // if id is present, then we are updating an existing note else we are creating a new one
  final String? id;

  // encrypted notes are loaded through the encrypted notes repository
  final bool encrypted;

  const InitializeNote({this.id, this.encrypted = false});
}

class UpdateNote extends NotesEvent {
  // only these 4 things can eb changed by user
  final DateTime? createdAt;
  final String? title;
  final String? body;
  final NoteAssetModel? noteAsset;

  const UpdateNote({this.createdAt, this.title, this.body, this.noteAsset});
}

/// Toggles whether this note is stored encrypted. The UI is responsible for
/// ensuring the encryption session is unlocked before enabling this.
class ToggleNoteEncryption extends NotesEvent {
  final bool encrypt;

  const ToggleNoteEncryption({required this.encrypt});
}

/// if newNote is true, then create a new note, otherwise update the existing note
class SaveNote extends NotesEvent {}

class AutoSaveNote extends NotesEvent {}

class DeleteNote extends NotesEvent {
  final List<String> noteList;

  const DeleteNote({required this.noteList});
}

/// Even if user discards the note, we have to delete all the saved assets
/// If newNote is true, then delete all assets, else delete only new assets
class DiscardNote extends NotesEvent {}

/// Removes all the info stored in state and starts with NoteDummyState again
class RefreshNote extends NotesEvent {}

class FetchNote extends NotesEvent {}

// Add new tag
class AddTag extends NotesEvent {
  final String newTag;

  const AddTag({required this.newTag});
}

// Removes the tag at given index
class DeleteTag extends NotesEvent {
  final int tagIndex;

  const DeleteTag({required this.tagIndex});
}
