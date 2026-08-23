import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encrypted_notes_repository.dart';
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

  /// Extracts the asset paths referenced in a (plaintext) note body.
  /// Used by the encrypted-notes path, which must parse assets before
  /// the body is encrypted.
  List<String> parseAssetPaths(String noteBody) {
    var noteBodyMap = jsonDecode(noteBody);
    List<String> noteAssets = [];

    for (var noteElement in noteBodyMap) {
      if (noteElement.containsKey("insert") &&
          noteElement["insert"].runtimeType != String) {
        var assetMap = noteElement["insert"];
        String? assetType = getAssetType(assetMap);

        if (assetType == null) {
          throw Exception("Invalid asset type");
        }
        noteAssets.add(assetMap[assetType]);
      }
    }

    return noteAssets;
  }

  String? getAssetType(dynamic assetMap) {
    if (assetMap.containsKey("image")) {
      return "image";
    } else if (assetMap.containsKey("video")) {
      return "video";
    } else if (assetMap.containsKey("audio")) {
      return "audio";
    }

    return null;
  }

  /// Computes the hash of the note currently in [state], matching what was
  /// stored: SHA-1 for plain notes, keyed HMAC for encrypted ones. Falls back
  /// to state.hash (treat as unchanged) when the hash can't be computed.
  Future<String> computeCurrentHash(NotesState state) async {
    String body = jsonEncode(state.controller!.document.toDelta().toJson());
    String noteBodyWithAssetPathsRemoved = replaceAssetPathsByAssetNames(body);

    final hashInput = state.title! +
        state.createdAt!.millisecondsSinceEpoch.toString() +
        noteBodyWithAssetPathsRemoved +
        state.tags!.join(",");

    if (state.isEncrypted) {
      // The repository reproduces the stored composition, using the
      // keychain stamped on the note's row (which may originate from
      // another device after sync)
      final hash =
          await sl<IEncryptedNotesRepository>().computeEditorHash(
        noteId: state.id,
        title: state.title!,
        body: body,
        createdAt: state.createdAt!,
        tags: state.tags!,
        wrappedDek: state.wrappedDek,
      );
      return hash ?? state.hash ?? "";
    }

    return generateHash(hashInput);
  }

  // Compares two notes based on their hash
  bool areNotesIdentical(NotesState state, String newHash) {
    return state.hash == newHash;
  }

  // Handles the onWillPop event logic
  Future<bool> handleWillPop(BuildContext context, NotesBloc notesBloc) async {
    if (notesBloc.state.controller != null && notesBloc.state.title != null) {
      String _hash = await computeCurrentHash(notesBloc.state);

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
