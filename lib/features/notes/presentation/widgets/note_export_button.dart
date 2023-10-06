import 'dart:io';
import 'dart:typed_data';

import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/features/notes/core/converters/delta_to_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../bloc/notes/notes_bloc.dart';

class NoteShareButton extends StatelessWidget {
  const NoteShareButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final popupTextColor =
        Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;
    NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);
    return BlocBuilder<NotesBloc, NotesState>(
      bloc: notesBloc,
      builder: (context, state) {
        if (state.safe && state is! NoteSaveLoading) {
          return Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                _showBottomSheet(context, state);
              },
            ),
          );
        }

        if (state is NoteSaveLoading) {
          return Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

void _showBottomSheet(BuildContext context, NotesState state) {
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      final mainTextColor =
          Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;
      return Container(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.code, color: mainTextColor),
              title: Text('Delta JSON', style: TextStyle(color: mainTextColor)),
              onTap: () async {
                Share.share('${state.controller!.document.toDelta().toJson()}');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: mainTextColor),
              title: Text(
                'PDF',
                style: TextStyle(color: mainTextColor),
              ),
              onTap: () async {
                var pdf = pw.Document();

                pdf.addPage(pw.Page(
                    pageFormat: PdfPageFormat.a4,
                    margin: pw.EdgeInsets.zero,
                    build: (pw.Context context) {
                      var delta = state.controller!.document.toDelta().toList();
                      DeltaToPDF dpdf = DeltaToPDF();
                      return dpdf.deltaToPDF(delta);
                    }));
                final tempPath = await getTemporaryDirectory();

                final file = File(tempPath.path + "/document.pdf");
                file.writeAsBytesSync(await pdf.save());

                final xfile = XFile(file.path);

                await Share.shareXFiles([xfile]);
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
            ListTile(
              leading: Icon(Icons.text_snippet, color: mainTextColor),
              title: Text('Plain Text', style: TextStyle(color: mainTextColor)),
              onTap: () {
                //Share to appropriate app
                Share.share('${state.controller!.document.toPlainText()}');
                Navigator.pop(context); // Close the bottom sheet
              },
            ),
            // Add more list items as needed
          ],
        ),
      );
    },
  );
}
