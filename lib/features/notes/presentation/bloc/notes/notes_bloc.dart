import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/notes/data/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository notesRepository;

  NotesBloc({required this.notesRepository})
      : super(
          NoteInitialState(newNote: true, note: Note.createDummy()),
        ) {
    on<InitializeNote>((event, emit) async {
      // if id is present, create a new note else fetch the existing note from database
      if (event.id == null) {
        var id = _generateUniqueId();
        var note = Note.initializeWithId(id);
        emit(NoteInitialState(newNote: true, note: note));
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

    on<UpdateNote>((event, emit) {});
  }

  // helper methods
  String _generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v1();
  }
}
