import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/domain/repositories/export_notes_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';

final log = printer("ExportNotesRepository");

class ExportNotesRepository implements IExportNotesRepository {
  final INotesRepository notesRepository;

  ExportNotesRepository({required this.notesRepository});

  @override
  Future<String> exportNotesToTextFile(
      {required File file, List<String>? noteList}) async {
    try {
      if (noteList == null) {
        final result = await notesRepository.fetchNotes();

        var fileContent = "";

        result.fold((l) => null, (allNotes) async {
          log.i("allNotes = $allNotes");

          for (var note in allNotes) {
            fileContent += note.title + "\n";

            fileContent += "Created at: " + note.createdAt.toString() + "\n";
            fileContent += note.plainText;
            fileContent += "\n\n---------------------------------\n\n";
          }
        });
        await file.writeAsString(fileContent);

        return file.path;
      }

      return "";
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
