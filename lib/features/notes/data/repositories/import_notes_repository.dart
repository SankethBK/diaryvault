import 'dart:convert';
import 'dart:io';

import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/notes/domain/repositories/import_notes_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';

final log = printer("ImportNotesRepository");

class ImportNotesRepository implements IImportNotesRepository {
  final INotesRepository notesRepository;

  ImportNotesRepository({required this.notesRepository});

  static const _requiredFields = [
    "id",
    "created_at",
    "title",
    "body",
    "hash",
    "last_modified",
    "plain_text",
  ];

  @override
  Future<ImportNotesResult> importNotesFromJsonFile(File file) async {
    final content = await file.readAsString();
    final decoded = jsonDecode(content);

    final List<dynamic> notesJson;
    if (decoded is List) {
      notesJson = decoded;
    } else if (decoded is Map<String, dynamic>) {
      // also allow importing a single note object (e.g. per-note .json files
      // from the dropbox backup folder)
      notesJson = [decoded];
    } else {
      throw Exception("Invalid backup file format");
    }

    int importedCount = 0;
    int skippedCount = 0;
    int failedCount = 0;

    for (final noteJson in notesJson) {
      try {
        if (noteJson is! Map<String, dynamic> ||
            _requiredFields.any((field) => noteJson[field] == null)) {
          log.e("skipping invalid note entry: $noteJson");
          failedCount++;
          continue;
        }

        // skip notes which are already present locally
        final existingNote = await notesRepository.getNote(noteJson["id"]);
        final noteExists = existingNote.fold((_) => false, (_) => true);
        if (noteExists) {
          skippedCount++;
          continue;
        }

        // Media files are not part of the JSON export, so asset paths in the
        // note body will be dead links after import. The asset dependencies
        // are still preserved as-is.
        final noteMap = <String, dynamic>{
          "id": noteJson["id"],
          "created_at": noteJson["created_at"],
          "title": noteJson["title"],
          "body": noteJson["body"],
          "hash": noteJson["hash"],
          "last_modified": noteJson["last_modified"],
          "plain_text": noteJson["plain_text"],
          "deleted": noteJson["deleted"] ?? 0,
          "asset_dependencies": [],
          "tags": (noteJson["tags"] as List?)?.cast<String>().toList() ?? [],
        };

        final result = await notesRepository.saveNote(
          noteMap,
          dontModifyAnyParameters: true,
        );

        result.fold((_) => failedCount++, (_) => importedCount++);
      } catch (e) {
        log.e("failed to import note: $e");
        failedCount++;
      }
    }

    log.i("import complete: imported = $importedCount, "
        "skipped = $skippedCount, failed = $failedCount");

    return ImportNotesResult(
      importedCount: importedCount,
      skippedCount: skippedCount,
      failedCount: failedCount,
    );
  }
}
