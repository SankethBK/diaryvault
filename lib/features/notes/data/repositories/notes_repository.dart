import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';

final log = printer("NotesRepository");

class NotesRepository implements INotesRepository {
  final INotesLocalDataSource notesLocalDataSource;

  NotesRepository({required this.notesLocalDataSource});

  @override
  Future<Either<NotesFailure, void>> deleteNote(String id) async {
    try {
      await notesLocalDataSource.deleteNote(id);
      return const Right(null);
    } catch (e) {
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, List<NoteModel>>> fetchNotes() async {
    try {
      var notesList = await notesLocalDataSource.fetchNotes();
      return Right(notesList);
    } catch (e) {
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, NoteModel>> getNote(String id) async {
    try {
      var note = await notesLocalDataSource.getNote(id);
      return Right(note);
    } catch (e) {
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, void>> saveNote(NoteModel note) async {
    try {
      await notesLocalDataSource.saveNote(note);
      return const Right(null);
    } catch (e) {
      return Left(NotesFailure.unknownError());
    }
  }

  @override
  Future<Either<NotesFailure, void>> updateNote(NoteModel note) async {
    try {
      await notesLocalDataSource.updateNote(note);
      return const Right(null);
    } catch (e) {
      return Left(NotesFailure.unknownError());
    }
  }
}
