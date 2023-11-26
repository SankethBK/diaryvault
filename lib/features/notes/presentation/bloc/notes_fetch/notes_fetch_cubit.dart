import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:equatable/equatable.dart';

part 'notes_fetch_state.dart';

class NotesFetchCubit extends Cubit<NotesFetchState> {
  final INotesRepository notesRepository;
  final NotesBloc notesBloc;
  final UserConfigCubit userConfigCubit;
  late StreamSubscription notesSubscription;

  final NoteSyncCubit noteSyncCubit;
  late StreamSubscription noteSyncSubscrption;

  NotesFetchCubit({
    required this.notesRepository,
    required this.notesBloc,
    required this.noteSyncCubit,
    required this.userConfigCubit,
  }) : super(const NotesFetchDummyState()) {
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

  Future<void> setNoteSortType(NoteSortType noteSortType) async {
    await userConfigCubit.setUserConfig(
        UserConfigConstants.noteSortType, noteSortType.text);

    sortNotes(noteSortType);
  }

  void sortNotes(NoteSortType noteSortType) {
    // Create a new list for sorting
    List<NotePreview> notePreviewList = List.from(state.notePreviewList);

    // Sort the notePreviewList based on the selected sort type
    switch (noteSortType) {
      case NoteSortType.sortByLatestFirst:
        notePreviewList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case NoteSortType.sortByOldestFirst:
        notePreviewList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case NoteSortType.sortByAtoZ:
        notePreviewList.sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      default:
        break;
    }

    emit(NotesSortSuccessful(
        notePreviewList: notePreviewList,
        isTagSearchEnabled: state.isTagSearchEnabled,
        tags: state.tags));
  }

  void toggleTagSearch() {
    if (state is NotesFetchSuccessful || state is NotesSortSuccessful) {
      emit(NotesFetchSuccessful(
          notePreviewList: state.notePreviewList,
          isTagSearchEnabled: !state.isTagSearchEnabled));
    }
  }

  void addNewTag(String newTag) {
    emit(NotesFetchSuccessful(
        notePreviewList: state.notePreviewList,
        tags: [newTag, ...state.tags],
        isTagSearchEnabled: state.isTagSearchEnabled));

    fetchNotes();
  }

  void deleteTag(int index) {
    final updatedTags = List<String>.from(state.tags);
    updatedTags.removeAt(index);

    emit(NotesFetchSuccessful(
        notePreviewList: state.notePreviewList,
        tags: updatedTags,
        isTagSearchEnabled: state.isTagSearchEnabled));

    fetchNotes();
  }

  void fetchNotes(
      {String? searchText, DateTime? startDate, DateTime? endDate}) async {
    emit(NotesFetchLoadingState(
        isTagSearchEnabled: state.isTagSearchEnabled, tags: state.tags));

    var result = await notesRepository.fetchNotesPreview(
      searchText: searchText,
      startDate: startDate,
      endDate: endDate,
      tags: state.tags,
    );
    result.fold((error) {
      emit(const NotesFetchFailed());
    }, (data) {
      // get the preferred note sort type
      final preferredNoteSortType =
          userConfigCubit.state.userConfigModel?.noteSortType;

      emit(NotesFetchSuccessful(
          notePreviewList: data,
          tags: state.tags,
          isTagSearchEnabled: state.isTagSearchEnabled));

      if (preferredNoteSortType != null) {
        sortNotes(preferredNoteSortType);
      }
    });
  }
}
