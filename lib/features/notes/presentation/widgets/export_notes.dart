import 'dart:io';

import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/features/notes/domain/repositories/export_notes_repository.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportNotes extends StatelessWidget {
  const ExportNotes({super.key});

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        SettingsTile(
          onTap: () async {
            // create a text file from the notes
            final directory = await getApplicationDocumentsDirectory();
            final file = File('${directory.path}/diaryvault_notes_export.txt');

            try {
              String filePath = await sl<IExportNotesRepository>()
                  .exportNotesToTextFile(file: file);

              // Share the file and await its completion
              await Share.shareXFiles([XFile(filePath)],
                  text: 'diaryvault_notes_export');

              await file.delete();
            } on Exception catch (e) {
              showToast(e.toString().replaceAll("Exception: ", ""));
            }
          },
          child: Text(
            S.current.exportToPlainText,
            style: TextStyle(
              fontSize: 16.0,
              color: mainTextColor,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        SettingsTile(
          onTap: () async {
            try {
              String filePath =
                  await sl<IExportNotesRepository>().exportNotesToPDF();

              // Share the file and await its completion
              await Share.shareXFiles([XFile(filePath)],
                  text: 'diaryvault_notes_export');
            } on Exception catch (e) {
              showToast(e.toString().replaceAll("Exception: ", ""));
            }
          },
          child: Text(
            S.current.exportToPDF,
            style: TextStyle(
              fontSize: 16.0,
              color: mainTextColor,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        SettingsTile(
          onTap: () async {
            try {
              // Call exportNotesToJsonFile without passing a file
              String filePath = await sl<IExportNotesRepository>().exportNotesToJsonFile();

              // Share the JSON file
              await Share.shareXFiles([XFile(filePath)], text: 'diaryvault_notes_export');

              // Optionally delete the file after sharing to avoid leftover files
              final file = File(filePath);
              if (await file.exists()) {
                await file.delete();
              }
            } catch (e) {
              showToast(e.toString().replaceAll("Exception: ", ""));
            }
          },
          child: Text(
            S.current.exportToJSON,
            style: TextStyle(
              fontSize: 16.0,
              color: mainTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
