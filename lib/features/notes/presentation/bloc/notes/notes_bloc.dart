import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:uuid/uuid.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final INotesRepository notesRepository;

  NotesBloc({required this.notesRepository})
      : super(const NoteDummyState(id: "")) {
    on<InitializeNote>((event, emit) async {
      // if id is present, create a new note else fetch the existing note from database
      if (event.id == null) {
        var _id = _generateUniqueId();
        QuillController _controller = QuillController(
            document: Document()..insert(0, ''),
            selection: const TextSelection.collapsed(offset: 0));

        emit(
          NoteInitialState(
            newNote: true,
            id: _id,
            title: "",
            createdAt: DateTime.now(),
            controller: _controller,
            allNoteAssets: [],
          ),
        );
        return;
      }

      emit(const NoteFetchLoading(id: ""));
      var result = await notesRepository.getNote(event.id!);

      result.fold(
        (error) {
          emit(const NoteFetchFailed(id: ""));
        },
        (note) {
          final _doc = Document.fromJson(jsonDecode(note.body));
          QuillController _controller = QuillController(
            document: _doc,
            selection: const TextSelection.collapsed(offset: 0),
          );

          emit(NoteInitialState(
            id: note.id,
            newNote: false,
            title: note.title,
            createdAt: note.createdAt,
            controller: _controller,
            allNoteAssets: note.assetDependencies,
          ));
        },
      );
    });

    on<UpdateNote>((event, emit) {
      // we don't want to update when something is getting saved or deleted
      // so we need to process the body afterwards to get current list of assets, and suitably delete removed ones

      emit(NoteUpdatedState(
        newNote: state.newNote!,
        id: state.id,
        title: event.title ?? state.title!,
        controller: state.controller!,
        createdAt: event.createdAt ?? state.createdAt!,
        allNoteAssets: event.noteAsset != null
            ? [...state.allNoteAssets!, event.noteAsset!]
            : state.allNoteAssets!,
      ));
    });

    on<SaveNote>((event, emit) async {
      // TODO: can add some validation like title and body can't be empty
      emit(NoteSaveLoading(
        newNote: state.newNote!,
        id: state.id,
        title: state.title!,
        controller: state.controller!,
        createdAt: state.createdAt!,
        noteAssets: state.allNoteAssets!,
      ));

      var _body = jsonEncode(state.controller!.document.toDelta().toJson());

      var _plainText = state.controller!.document.toPlainText();

      state.controller!.dispose();

      var noteMap = {
        "id": state.id,
        "created_at": state.createdAt!.millisecondsSinceEpoch,
        "title": state.title!,
        "body": _body,
        "last_modified": DateTime.now().millisecondsSinceEpoch,
        "plain_text": _plainText,
        "asset_dependencies": state.allNoteAssets,
        "deleted": 0,
      };

      Either<NotesFailure, void> result;

      // For smooth UX, it displays CIrcularProgressindicator till then
      await Future.delayed(const Duration(seconds: 1));

      if (state.newNote!) {
        result = await notesRepository.saveNote(noteMap);
      } else {
        result = await notesRepository.updateNote(noteMap);
      }
      result.fold((error) {
        emit(NotesSavingFailed(
          newNote: state.newNote!,
          id: state.id,
          title: state.title!,
          controller: state.controller!,
          createdAt: state.createdAt!,
          noteAssets: state.allNoteAssets!,
        ));
      }, (_) {
        emit(NoteSavedSuccesfully(
          newNote: state.newNote!,
          id: state.id,
          title: state.title!,
          controller: state.controller!,
          createdAt: state.createdAt!,
          noteAssets: state.allNoteAssets!,
        ));
      });
    });

    on<AutoSaveNote>((event, emit) async {
      emit(NoteSaveLoading(
        newNote: state.newNote!,
        id: state.id,
        title: state.title!,
        controller: state.controller!,
        createdAt: state.createdAt!,
        noteAssets: state.allNoteAssets!,
      ));

      var _body = jsonEncode(state.controller!.document.toDelta().toJson());

      var _plainText = state.controller!.document.toPlainText();

      var noteMap = {
        "id": state.id,
        "created_at": state.createdAt!.millisecondsSinceEpoch,
        "title": state.title!,
        "body": _body,
        "last_modified": DateTime.now().millisecondsSinceEpoch,
        "plain_text": _plainText,
        "asset_dependencies": state.allNoteAssets,
        "deleted": 0,
      };

      Either<NotesFailure, void> result;

      // For smooth UX, it displays CIrcularProgressindicator till then
      await Future.delayed(const Duration(seconds: 1));

      if (state.newNote!) {
        result = await notesRepository.saveNote(noteMap);
      } else {
        result = await notesRepository.updateNote(noteMap);
      }
      result.fold((error) {
        emit(NotesAutoSavingFailed(
          newNote: false,
          id: state.id,
          title: state.title!,
          controller: state.controller!,
          createdAt: state.createdAt!,
          noteAssets: state.allNoteAssets!,
        ));
      }, (_) {
        emit(NoteAutoSavedSuccesfully(
          newNote: false,
          id: state.id,
          title: state.title!,
          controller: state.controller!,
          createdAt: state.createdAt!,
          noteAssets: state.allNoteAssets!,
        ));
      });
    });

    on<DeleteNote>((event, emit) async {
      emit(const NoteDeleteLoading(id: ""));
      var result = await notesRepository.deleteNotes(event.noteList);

      result.fold((e) {
        emit(const NoteDeletionFailed(id: ""));
      }, (_) {
        emit(const NoteDeletionSuccesful(id: ""));
      });
    });

    on<RefreshNote>((event, emit) {
      emit(const NoteDummyState(id: ""));
    });

    on<FetchNote>((event, emit) {
      emit(const FetchAfterAutoSave(id: ""));
    });
  }

  // helper methods
  String _generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v1();
  }
}
