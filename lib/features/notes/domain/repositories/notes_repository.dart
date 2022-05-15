import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/notes_model.dart';

abstract class INotesRepository {
  Future<Either<NotesFailure, NoteModel>> saveNote(NoteModel note);

  Future<Either<NotesFailure, List<NoteModel>>> fetchNotes();

  Future<Either<NotesFailure, NoteModel>> getNote(String id);

  Future<Either<NotesFailure, void>> updateNote(NoteModel note);

  Future<void> deleteNote(String id);
}
