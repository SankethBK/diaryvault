part of 'notes_fetch_cubit.dart';

abstract class NotesFetchState extends Equatable {
  final List<NotePreview> notePreviewList;
  final bool safe;

  const NotesFetchState({required this.notePreviewList, required this.safe});

  @override
  List<Object> get props => [notePreviewList];
}

class NotesFetchDummyState extends NotesFetchState {
  const NotesFetchDummyState() : super(notePreviewList: const [], safe: false);
}

class NotesFetchLoadingState extends NotesFetchState {
  const NotesFetchLoadingState()
      : super(notePreviewList: const [], safe: false);
}

class NotesFetchFailed extends NotesFetchState {
  const NotesFetchFailed() : super(notePreviewList: const [], safe: false);
}

class NotesFetchSuccessful extends NotesFetchState {
  const NotesFetchSuccessful({required List<NotePreview> notePreviewList})
      : super(notePreviewList: notePreviewList, safe: true);
}

class NotesSortSuccessful extends NotesFetchState {
  const NotesSortSuccessful({required List<NotePreview> notePreviewList})
      : super(notePreviewList: notePreviewList, safe: true);
}
