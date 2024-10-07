import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/widgets/show_notes_close_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;

mixin NoteHelperMixin {
  // Replaces absolute paths of assets with their file names
  String replaceAssetPathsByAssetNames(String noteBody) {
    var noteBodyMap = jsonDecode(noteBody);

    for (Map<String, dynamic> noteElement in noteBodyMap) {
      if (noteElement.containsKey("insert") &&
          noteElement["insert"].runtimeType != String) {
        if (noteElement["insert"].containsKey("image") &&
            !(noteElement["insert"]["image"] as String).startsWith("http")) {
          noteElement["insert"]["image"] =
              p.basename(noteElement["insert"]["image"]);
        } else if (noteElement["insert"].containsKey("video") &&
            !(noteElement["insert"]["video"] as String).startsWith("http")) {
          noteElement["insert"]["video"] =
              p.basename(noteElement["insert"]["video"]);
        }
      }
    }

    return jsonEncode(noteBodyMap);
  }

  // Generates SHA-1 hash for the given text
  String generateHash(String text) {
    var bytes = utf8.encode(text);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  // Compares two notes based on their hash
  bool areNotesIdentical(NotesState state, String newHash) {
    return state.hash == newHash;
  }

  // Handles the onWillPop event logic
  Future<bool> handleWillPop(BuildContext context, NotesBloc notesBloc) async {
    if (notesBloc.state.controller != null && notesBloc.state.title != null) {
      String _body =
          jsonEncode(notesBloc.state.controller!.document.toDelta().toJson());

      // Calculate note hash
      String noteBodyWithAssetPathsRemoved =
          replaceAssetPathsByAssetNames(_body);

      String _hash = generateHash(notesBloc.state.title! +
          notesBloc.state.createdAt!.millisecondsSinceEpoch.toString() +
          noteBodyWithAssetPathsRemoved +
          notesBloc.state.tags!.join(","));

      // Compare old and new hash
      if (areNotesIdentical(notesBloc.state, _hash)) {
        notesBloc.add(RefreshNote());

        return true;
      } else {
        bool? result = await showCloseDialog(context);

        if (result == true) {
          notesBloc.add(RefreshNote());
          return true;
        }
        return false;
      }
    }
    return false;
  }
}
