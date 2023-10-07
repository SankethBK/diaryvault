import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:equatable/equatable.dart';

part 'notes_fetch_state.dart';

class NotesFetchCubit extends Cubit<NotesFetchState> {
  final INotesRepository notesRepository;
  final NotesBloc notesBloc;
  late StreamSubscription notesSubscription;

  final NoteSyncCubit noteSyncCubit;
  late StreamSubscription noteSyncSubscrption;

  NotesFetchCubit(
      {required this.notesRepository,
      required this.notesBloc,
      required this.noteSyncCubit})
      : super(const NotesFetchDummyState()) {
    notesSubscription = notesBloc.stream.listen((state) {
      if (state is NoteSavedSuccesfully) {
        fetchNotes();
      }
      if (state is FetchAfterAutoSave) {
        fetchNotes();
      }
      if (state is NoteDeletionSuccesful) {
        fetchNotes();
      }
    });

    noteSyncSubscrption = noteSyncCubit.stream.listen((state) {
      if (state is NoteSyncSuccessful) {
        fetchNotes();
      }
    });
  }

  void fetchNotes(
      {String? searchText, DateTime? startDate, DateTime? endDate}) async {
    emit(const NotesFetchLoadingState());

    var result = await notesRepository.fetchNotesPreview(
      searchText: searchText,
      startDate: startDate,
      endDate: endDate,
    );
    result.fold((error) {
      emit(const NotesFetchFailed());
    }, (data) {
      emit(NotesFetchSuccessful(notePreviewList: data));
    });
  }
}
