import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/domain/repositories/export_notes_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:markdown/markdown.dart';
import 'package:path_provider/path_provider.dart';

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

  @override
  Future<String> exportNotesToPDF({List<String>? noteList}) async {
    // create a text file from the notes
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/diaryvault_notes_export.txt');

    try {
      if (noteList == null) {
        final result = await notesRepository.fetchNotes();

        var fileContent = "";

        result.fold((l) => null, (allNotes) async {
          for (var note in allNotes) {
            fileContent += "<h2>${note.title}</h2>";

            fileContent +=
                "<i>Created at:  + ${note.createdAt.toString()} </i>";
            fileContent += "</br>";
            fileContent += quillDeltaToHtml(note.body);
          }
        });
        print("fileContent = $fileContent");
        await file.writeAsString(fileContent);
        var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlFile(
            file, directory.path, "diayvault_pdf_export");

        return generatedPdfFile.path;
      }

      return "";
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  // utils

  String quillDeltaToHtml(String delta) {
    print("delta = $delta");
    final markdown = deltaToMarkdown(delta);
    final html = markdownToHtml(markdown);

    return html;
  }
}
