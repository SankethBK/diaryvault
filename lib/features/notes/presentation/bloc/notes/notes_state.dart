part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  final bool newNote;
  final Note note;

  const NotesState({required this.newNote, required this.note});

  @override
  List<Object> get props => [newNote, note];
}

/// Initial state, when a new note is getting created, or an existing note is opened
class NoteInitialState extends NotesState {
  const NoteInitialState({required bool newNote, required Note note})
      : super(newNote: newNote, note: note);
}

/// once the user starts editing, [NoteInitialState] changes to [NoteUpdatedState]
class NoteUpdatedState extends NotesState {
  const NoteUpdatedState({required bool newNote, required Note note})
      : super(newNote: newNote, note: note);
}

class NoteFetchLoading extends NotesState {
  const NoteFetchLoading({required bool newNote, required Note note})
      : super(newNote: newNote, note: note);
}
