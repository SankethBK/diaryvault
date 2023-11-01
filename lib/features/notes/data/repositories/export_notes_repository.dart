import 'dart:convert';
import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/domain/repositories/export_notes_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:delta_markdown/delta_markdown.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:intl/intl.dart';
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
        log.i("Generating text file for all notes");

        final result = await notesRepository.fetchNotes();

        var fileContent = "";

        result.fold((l) => null, (allNotes) async {
          for (var note in allNotes) {
            fileContent += note.title + "\n";

            fileContent += "Created at: " + formatDate(note.createdAt) + "\n";
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
        log.i("Generating PDF for all notes");

        final result = await notesRepository.fetchNotes();

        // Add watermark

        var fileContent = "";

        String watermarkFile =
            await getImageFileFromAssets('assets/images/watermark.png');

        fileContent +=
            "<img width=\"1000\" src=\"$watermarkFile\"  alt=\"web-img\">";

        result.fold((l) => null, (allNotes) async {
          for (var note in allNotes) {
            fileContent += "<h2>${note.title}</h2>";

            fileContent += "<i>Created at: ${formatDate(note.createdAt)} </i>";
            fileContent += "</br>";
            fileContent += quillDeltaToHtml(note.body);
          }
        });

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
    final markdown = deltaToMarkdown(delta);
    final html = markdownToHtml(markdown);

    return html;
  }

  String formatDate(DateTime date) {
    return DateFormat.yMMMEd().format(date) +
        ", " +
        DateFormat.jm().format(date);
  }

  Future<String> getImageFileFromAssets(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final String base64Image = base64Encode(bytes);

    final String dataUri = 'data:image/png;base64, $base64Image';
    return dataUri;
  }
}
