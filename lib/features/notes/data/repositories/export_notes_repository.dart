import 'dart:convert';
import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/core/failures/failure.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/repositories/export_notes_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dartz/dartz.dart';
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
  Future<String> exportNotesToJsonFile({List<String>? noteList}) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/diaryvault_notes_export_${DateTime.now().millisecondsSinceEpoch}.json');

    try {
      Either<NotesFailure, List<NoteModel>> result;

      if (noteList == null) {
        log.i("Generating JSON for all notes");
        result = await notesRepository.fetchNotes();
      } else {
        log.i("Generating JSON for $noteList");
        result = await notesRepository.fetchNotes(noteIds: noteList);
      }

      // On success, convert notes to JSON array
      String jsonString = "";
      await result.fold(
        (failure) async {
          // Handle failure - log and throw
          log.e("Failed to fetch notes for JSON export");
          throw Exception("Failed to fetch notes");
        },
        (allNotes) async {
          // Convert list of NoteModel to list of JSON maps
          final List<Map<String, dynamic>> notesJson = allNotes.map((note) => note.toJson()).toList();
          jsonString = jsonEncode(notesJson);
        },
      );

      await file.writeAsString(jsonString);

      return file.path;
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<String> exportNotesToTextFile(
      {required File file, List<String>? noteList}) async {
    try {
      Either<NotesFailure, List<NoteModel>> result;

      if (noteList == null) {
        log.i("Generating text file for all notes");

        result = await notesRepository.fetchNotes();
      } else {
        log.i("Generating text file for $noteList");

        result = await notesRepository.fetchNotes(noteIds: noteList);
      }

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
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  String addMarginsToHTML(String htmlContent) {
    return '''
    <html>
      <head>
        <style>
          @page {
            margin: 40px;
          }
          body {
            margin: 20px;
          }
          h2, h3, p {
            margin: 0 0 10px;
          }
          img {
            max-width: 100%;
            height: auto;
            page-break-inside: avoid;
            max-height: 500px;
          }
        </style>
      </head>
      <body>
        $htmlContent
      </body>
    </html>
  ''';
  }

  @override
  Future<String> exportNotesToPDF({List<String>? noteList}) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/diaryvault_notes_export.txt');

    try {
      Either<NotesFailure, List<NoteModel>> result;

      if (noteList == null) {
        log.i("Generating PDF for all notes");

        result = await notesRepository.fetchNotes();
      } else {
        log.i("Generating PDF for $noteList");

        result = await notesRepository.fetchNotes(noteIds: noteList);
      }

      var fileContent = "";

      String watermarkFile =
          await getImageFileFromAssets('assets/images/watermark.webp');

      fileContent +=
          "<img width=\"1000\" src=\"$watermarkFile\" alt=\"web-img\">";

      result.fold((l) => null, (allNotes) async {
        for (var note in allNotes) {
          fileContent += "<h2>${note.title}</h2>";

          fileContent += "<i>Created at: ${formatDate(note.createdAt)} </i>";
          fileContent += "<br>";

          final preprocessedDelta = preprocessDeltaForPDFExport(note.body);
          fileContent += quillDeltaToHtml(preprocessedDelta);

          fileContent += "<hr><br>";
        }
      });

      // Add margins to the HTML content
      final htmlWithMargins = addMarginsToHTML(fileContent);

      await file.writeAsString(htmlWithMargins);

      var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlFile(
          file, directory.path, "diaryvault_pdf_export");

      return generatedPdfFile.path;
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

  // PDF is generated by converting delta to markdown and then to HTML
  // Some elements and attributes are not supported for conversion or needs modification
  String preprocessDeltaForPDFExport(String delta) {
    var deltaMap = jsonDecode(delta);

    for (Map<String, dynamic> deltaElement in deltaMap) {
      // Local images needs to be prefixed with file:///

      if (deltaElement.containsKey("insert") &&
          deltaElement["insert"].runtimeType != String &&
          deltaElement["insert"].containsKey("image") &&
          !(deltaElement["insert"]["image"] as String).startsWith("http")) {
        deltaElement["insert"]["image"] =
            "file://" + deltaElement["insert"]["image"];
      }

      // Remove unsupported attributes on text

      if (deltaElement.containsKey("insert") &&
          deltaElement["insert"].runtimeType == String) {
        if (deltaElement.containsKey("attributes")) {
          // 1. Remove underline
          deltaElement["attributes"].remove("underline");

          // 2. Remove Strikethrough
          deltaElement["attributes"].remove("strike");

          // 3. Remove color
          deltaElement["attributes"].remove("color");

          // 4. Remove background color
          deltaElement["attributes"].remove("background");

          // 5. Remove checklist
          deltaElement["attributes"].remove("list");

          // 6. Remove subscript and superscript
          deltaElement["attributes"].remove("script");
        }
      }
    }

    return jsonEncode(deltaMap);
  }
}
