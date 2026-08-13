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
            // ignore: prefer_const_literals_to_create_immutables
            allNoteAssets: [],
            // ignore: prefer_const_literals_to_create_immutables
            tags: [], hash: '',
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
          // Never open a locked placeholder for editing - saving it would
          // overwrite the real encrypted content with the placeholder
          if (note.isLockedPlaceholder) {
            emit(const NoteFetchFailed(id: ""));
            return;
          }

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
            tags: note.tags,
            hash: note.hash,
            isEncrypted: note.isEncrypted,
            wrappedDek: note.wrappedDek,
          ));
        },
      );
    });

    on<ToggleNoteEncryption>((event, emit) {
      emit(NoteUpdatedState(
        newNote: state.newNote!,
        id: state.id,
        title: state.title!,
        controller: state.controller!,
        createdAt: state.createdAt!,
        allNoteAssets: state.allNoteAssets!,
        tags: state.tags ?? [],
        isEncrypted: event.encrypt,
        wrappedDek: state.wrappedDek,
      ));
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
        tags: state.tags ?? [],
        isEncrypted: state.isEncrypted,
        wrappedDek: state.wrappedDek,
      ));
    });

    on<AddTag>((event, emit) {
      emit(NoteUpdatedState(
        newNote: state.newNote!,
        id: state.id,
        title: state.title!,
        controller: state.controller!,
        createdAt: state.createdAt!,
        allNoteAssets: state.allNoteAssets!,
        tags: [event.newTag, ...state.tags!],
        isEncrypted: state.isEncrypted,
        wrappedDek: state.wrappedDek,
      ));
    });

    on<DeleteTag>((event, emit) {
      // Create a copy of the tags list without the element at event.tagIndex
      final updatedTags = List<String>.from(state.tags!);
      updatedTags.removeAt(event.tagIndex);

      emit(NoteUpdatedState(
        newNote: state.newNote!,
        id: state.id,
        title: state.title!,
        controller: state.controller!,
        createdAt: state.createdAt!,
        allNoteAssets: state.allNoteAssets!,
        tags: updatedTags,
        isEncrypted: state.isEncrypted,
        wrappedDek: state.wrappedDek,
      ));
    });

    on<SaveNote>((event, emit) async {
      emit(NoteSaveLoading(
        newNote: state.newNote!,
        id: state.id,
        title: state.title!,
        controller: state.controller!,
        createdAt: state.createdAt!,
        noteAssets: state.allNoteAssets!,
        tags: state.tags!,
        isEncrypted: state.isEncrypted,
        wrappedDek: state.wrappedDek,
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
        "tags": state.tags,
        "is_encrypted": state.isEncrypted ? 1 : 0,
        "wrapped_dek": state.wrappedDek,
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
          tags: state.tags ?? [],
          isEncrypted: state.isEncrypted,
          wrappedDek: state.wrappedDek,
        ));
      }, (_) {
        emit(NoteSavedSuccesfully(
          newNote: state.newNote!,
          id: state.id,
          title: state.title!,
          controller: state.controller!,
          createdAt: state.createdAt!,
          noteAssets: state.allNoteAssets!,
          tags: state.tags ?? [],
          isEncrypted: state.isEncrypted,
          wrappedDek: state.wrappedDek,
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
        tags: state.tags!,
        isEncrypted: state.isEncrypted,
        wrappedDek: state.wrappedDek,
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
        "tags": state.tags,
        "is_encrypted": state.isEncrypted ? 1 : 0,
        "wrapped_dek": state.wrappedDek,
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
          tags: state.tags!,
          isEncrypted: state.isEncrypted,
          wrappedDek: state.wrappedDek,
        ));
      }, (_) {
        emit(NoteAutoSavedSuccesfully(
          newNote: false,
          id: state.id,
          title: state.title!,
          controller: state.controller!,
          createdAt: state.createdAt!,
          noteAssets: state.allNoteAssets!,
          tags: state.tags!,
          isEncrypted: state.isEncrypted,
          wrappedDek: state.wrappedDek,
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
