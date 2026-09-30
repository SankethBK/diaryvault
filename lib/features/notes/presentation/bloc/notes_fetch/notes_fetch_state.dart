part of 'notes_fetch_cubit.dart';

abstract class NotesFetchState extends Equatable {
  final List<NotePreview> notePreviewList;
  final bool safe;
  final bool isTagSearchEnabled;
  final List<String> tags;
  final String searchText;

  const NotesFetchState({
    required this.notePreviewList,
    required this.safe,
    this.isTagSearchEnabled = false,
    this.tags = const [],
    this.searchText = '',
  });

  @override
  List<Object> get props => [notePreviewList];
}

class NotesFetchDummyState extends NotesFetchState {
  const NotesFetchDummyState()
      : super(
          notePreviewList: const [],
          safe: false,
        );
}

class NotesFetchLoadingState extends NotesFetchState {
  const NotesFetchLoadingState({
    bool isTagSearchEnabled = false,
    List<String> tags = const [],
    String searchText = '',
  }) : super(
            notePreviewList: const [],
            safe: false,
            tags: tags,
            isTagSearchEnabled: isTagSearchEnabled,
            searchText: searchText);
}

class NotesFetchFailed extends NotesFetchState {
  const NotesFetchFailed() : super(notePreviewList: const [], safe: false);
}

class NotesFetchSuccessful extends NotesFetchState {
  const NotesFetchSuccessful({
    required List<NotePreview> notePreviewList,
    bool isTagSearchEnabled = false,
    List<String> tags = const [],
    String searchText = '',
  }) : super(
            notePreviewList: notePreviewList,
            safe: true,
            isTagSearchEnabled: isTagSearchEnabled,
            tags: tags,
            searchText: searchText);

  @override
  List<Object> get props => [notePreviewList, isTagSearchEnabled, tags];
}

class NotesSortSuccessful extends NotesFetchState {
  const NotesSortSuccessful({
    required List<NotePreview> notePreviewList,
    bool isTagSearchEnabled = false,
    List<String> tags = const [],
    String searchText = '',
  }) : super(
            notePreviewList: notePreviewList,
            safe: true,
            isTagSearchEnabled: isTagSearchEnabled,
            tags: tags,
            searchText: searchText);

  @override
  List<Object> get props => [notePreviewList, isTagSearchEnabled, tags];
}
