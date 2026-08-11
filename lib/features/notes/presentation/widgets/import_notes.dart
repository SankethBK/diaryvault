import 'dart:io';

import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/features/notes/domain/repositories/import_notes_repository.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImportNotes extends StatefulWidget {
  const ImportNotes({super.key});

  @override
  State<ImportNotes> createState() => _ImportNotesState();
}

class _ImportNotesState extends State<ImportNotes> {
  bool isImporting = false;

  Future<void> _importFromJson() async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      final filePath = pickedFile?.files.single.path;
      if (filePath == null) {
        return;
      }

      setState(() {
        isImporting = true;
      });

      final result = await sl<IImportNotesRepository>()
          .importNotesFromJsonFile(File(filePath));

      sl<NotesFetchCubit>().fetchNotes();

      if (result.failedCount > 0) {
        showToast(S.current.notesImportPartialFailure(
            result.importedCount, result.skippedCount, result.failedCount));
      } else if (result.skippedCount > 0) {
        showToast(S.current
            .notesImportSkippedSummary(result.importedCount, result.skippedCount));
      } else {
        showToast(S.current.notesImportSuccess(result.importedCount));
      }
    } catch (e) {
      showToast(S.current.invalidBackupFile);
    } finally {
      setState(() {
        isImporting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return SettingsTile(
      onTap: isImporting ? null : _importFromJson,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.current.importFromJSON,
            style: TextStyle(
              fontSize: 16.0,
              color: mainTextColor,
            ),
          ),
          if (isImporting) ...[
            const SizedBox(width: 10),
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ],
      ),
    );
  }
}
