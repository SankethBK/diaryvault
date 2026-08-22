import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encryption_cubit.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/unlock_dialog.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Editor app-bar action that marks the current note as encrypted.
/// Shown only when encryption is enabled. Enabling on a note while the
/// session is locked prompts for the passphrase first.
class NoteEncryptToggleButton extends StatelessWidget {
  const NoteEncryptToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final encryptionCubit = BlocProvider.of<EncryptionCubit>(context);

    return BlocBuilder<EncryptionCubit, EncryptionSessionState>(
      bloc: encryptionCubit,
      builder: (context, encryptionState) {
        // lock button only appears once encryption is enabled
        if (encryptionState is EncryptionDisabled) {
          return const SizedBox.shrink();
        }

        return BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (!state.safe) return const SizedBox.shrink();

            return IconButton(
              icon: Icon(
                state.isEncrypted ? Icons.lock : Icons.lock_open,
                size: 22,
              ),
              tooltip: state.isEncrypted
                  ? "Remove encryption from this note"
                  : "Encrypt this note",
              onPressed: () async {
                if (state.isEncrypted) {
                  // decrypting back to a plain note needs no session
                  BlocProvider.of<NotesBloc>(context)
                      .add(const ToggleNoteEncryption(encrypt: false));
                  showToast("Note will be saved unencrypted");
                  return;
                }

                if (encryptionState is EncryptionLocked) {
                  final unlocked = await showUnlockDialog(context);
                  if (unlocked != true || !context.mounted) return;
                }

                BlocProvider.of<NotesBloc>(context)
                    .add(const ToggleNoteEncryption(encrypt: true));
                showToast("Note will be saved encrypted");
              },
            );
          },
        );
      },
    );
  }
}
