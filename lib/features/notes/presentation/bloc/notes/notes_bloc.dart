import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/data/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final INotesRepository notesRepository;

  NotesBloc({required this.notesRepository})
      : super(
          NoteInitialState(newNote: true, note: Note.createDummy()),
        ) {
    on<InitializeNote>((event, emit) async {
      // if id is present, create a new note else fetch the existing note from database
      if (event.id == null) {
        var id = _generateUniqueId();
        state.note.id = id;
        emit(NoteInitialState(newNote: true, note: state.note));
        return;
      }

      emit(NoteFetchLoading(newNote: false, note: state.note));
      var result = await notesRepository.getNote(event.id!);

      result.fold(
        (error) {},
        (note) {
          emit(NoteInitialState(newNote: false, note: note));
        },
      );
    });

    on<UpdateNote>((event, emit) {
      if (state is NoteInitialState || state is NoteUpdatedState) {
        // TODO: need to handle asset dependecies more clearly, there is no callback for asset removal
        // so we need to process the body afterwards to get current list of assets, and suitably delete removed ones
        emit(NoteUpdatedState(
          newNote: state.newNote,
          note: Note(
            id: state.note.id,
            title: event.title ?? state.note.title,
            body: event.body ?? state.note.body,
            assetDependencies: event.noteAsset != null
                ? [...state.note.assetDependencies, event.noteAsset!]
                : state.note.assetDependencies,
            hash: state.note.hash,
            createdAt: state.note.createdAt,
            lastModified: state.note.lastModified,
            plainText: state.note.plainText,
          ),
        ));
      }
    });

    on<SaveNote>((event, emit) async {
      // TODO: can add some validation like title and body can't be empty
      emit(NoteSaveLoading(newNote: state.newNote, note: state.note));
      var hash = _generateHash(state.note.getHashingString());
      state.note.hash = hash;
      var result = await notesRepository.saveNote(state.note as NoteModel);
      result.fold((error) {
        emit(NotesSavingFailed(newNote: state.newNote, note: state.note));
      }, (_) {
        emit(NoteSavedSuccesfully(newNote: state.newNote, note: state.note));
      });
    });
  }

  // helper methods
  String _generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  String _generateHash(String text) {
    var bytes = utf8.encode(text);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }
}
