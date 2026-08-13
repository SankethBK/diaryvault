import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/features/encryption/domain/repositories/key_manager.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encryption_cubit.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/encryption_setup_dialog.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/unlock_dialog.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Editor app-bar action that marks the current note as encrypted.
///
/// Enabling requires an unlocked encryption session: if encryption was never
/// set up, the onboarding dialog is launched; if locked, the unlock dialog.
class NoteEncryptToggleButton extends StatelessWidget {
  const NoteEncryptToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final encryptionCubit = BlocProvider.of<EncryptionCubit>(context);

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
              // decrypting back to a plain note never needs the session
              BlocProvider.of<NotesBloc>(context)
                  .add(const ToggleNoteEncryption(encrypt: false));
              showToast("Note will be saved unencrypted");
              return;
            }

            final encryptionState = encryptionCubit.state;

            if (encryptionState is EncryptionNotSetUp) {
              final setupDone = await showEncryptionSetupDialog(context);
              if (setupDone != true || !context.mounted) return;
            } else if (encryptionState is EncryptionLocked) {
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
  }
}
