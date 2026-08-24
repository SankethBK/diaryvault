import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/mixins/note_helper_mixin.dart';
import 'package:dairy_app/features/notes/presentation/widgets/show_notes_close_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/user_config/user_config_cubit.dart';

class NotesCloseButton extends StatelessWidget with NoteHelperMixin {
  final Function() onNotesClosed;

  const NotesCloseButton({Key? key, required this.onNotesClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.safe) {
          return IconButton(
            icon: const Icon(
              Icons.close,
              size: 25,
            ),
            onPressed: () async {
              await _handleCloseButtonPressed(context, state);
            },
          );
        }
        return Container();
      },
    );
  }

  Future<void> _handleCloseButtonPressed(
      BuildContext context, NotesState state) async {
    final notesBloc = context.read<NotesBloc>();
    if (state.controller != null && state.title != null) {
      String _hash = await computeCurrentHash(state);

      // Compare old and new hash
      if (areNotesIdentical(state, _hash)) {
        onNotesClosed();
      } else {
        final autoSaveEnabled = context
                .read<UserConfigCubit>()
                .state
                .userConfigModel
                ?.isAutoSaveEnabled ??
            true;
        if (autoSaveEnabled) {
          final saved = notesBloc.stream
              .where((state) =>
                  state is NoteAutoSavedSuccesfully ||
                  state is NotesAutoSavingFailed)
              .first;
          notesBloc.add(AutoSaveNote());
          final result = await saved;
          if (result is NoteAutoSavedSuccesfully) onNotesClosed();
          return;
        }
        bool? result = await showCloseDialog(context);
        if (result != null && result == true) {
          onNotesClosed();
        }
      }
    }
  }
}
