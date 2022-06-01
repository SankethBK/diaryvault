import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:equatable/equatable.dart';

part 'notes_fetch_state.dart';

class NotesFetchCubit extends Cubit<NotesFetchState> {
  final INotesRepository notesRepository;
  final NotesBloc notesBloc;
  late StreamSubscription notesSubscription;

  NotesFetchCubit({required this.notesRepository, required this.notesBloc})
      : super(const NotesFetchDummyState()) {
    notesSubscription = notesBloc.stream.listen((state) {
      // TODO: need to add more events here which results change of notes like deleting
      if (state is NoteSavedSuccesfully) {
        fetchNotes();
      }
      if (state is NoteDeletionSuccesful) {
        fetchNotes();
      }
    });
  }

  void fetchNotes() async {
    emit(const NotesFetchLoadingState());

    var result = await notesRepository.fetchNotesPreview();
    result.fold((error) {
      emit(const NotesFetchFailed());
    }, (data) {
      emit(NotesFetchSuccessful(notePreviewList: data));
    });
  }
}
