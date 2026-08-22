import 'package:dairy_app/features/encryption/domain/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encryption_cubit.dart';
import 'package:dairy_app/features/encryption/presentation/pages/encrypted_notes_page.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Mini lock FAB above the main "+" FAB on the home page, shown only when
/// encryption is enabled. Locked: prompts for passphrase, then opens the
/// encrypted notes view. Unlocked: opens it directly.
class EncryptionFab extends StatelessWidget {
  const EncryptionFab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final encryptionCubit = BlocProvider.of<EncryptionCubit>(context);

    return BlocBuilder<EncryptionCubit, EncryptionSessionState>(
      bloc: encryptionCubit,
      builder: (context, state) {
        if (state is EncryptionDisabled) {
          return const SizedBox.shrink();
        }

        final isUnlocked = state is EncryptionUnlocked;

        return FloatingActionButton.small(
          heroTag: "encryption_fab",
          tooltip: "Encrypted notes",
          child: Icon(isUnlocked ? Icons.lock_open : Icons.lock),
          onPressed: () async {
            if (!isUnlocked) {
              final unlocked = await showUnlockDialog(context);
              if (unlocked != true || !context.mounted) return;
            }
            Navigator.of(context).pushNamed(EncryptedNotesPage.route);
          },
        );
      },
    );
  }
}
