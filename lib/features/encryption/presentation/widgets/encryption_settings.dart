import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/features/encryption/domain/repositories/key_manager.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encryption_cubit.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/change_passphrase_dialog.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/encryption_setup_dialog.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/unlock_dialog.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Security settings section for per-note encryption.
///
/// Not set up -> tile that launches the onboarding dialog.
/// Set up     -> status tile + change passphrase + lock now.
class EncryptionSettings extends StatelessWidget {
  const EncryptionSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    final encryptionCubit = BlocProvider.of<EncryptionCubit>(context);

    return BlocBuilder<EncryptionCubit, EncryptionSessionState>(
      bloc: encryptionCubit,
      builder: (context, state) {
        if (state is EncryptionNotSetUp) {
          return Material(
            color: Colors.transparent,
            child: SettingsTile(
              child: Text(
                "Encrypt notes",
                style: TextStyle(fontSize: 16.0, color: mainTextColor),
              ),
              onTap: () async {
                final setupDone = await showEncryptionSetupDialog(context);
                if (setupDone == true && context.mounted) {
                  showToast("Encryption enabled");
                }
              },
            ),
          );
        }

        final isUnlocked = state is EncryptionUnlocked;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.transparent,
              child: SettingsTile(
                child: Row(
                  children: [
                    Icon(
                      isUnlocked ? Icons.lock_open : Icons.lock,
                      color: mainTextColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isUnlocked
                          ? "Note encryption (unlocked)"
                          : "Note encryption (locked)",
                      style: TextStyle(fontSize: 16.0, color: mainTextColor),
                    ),
                  ],
                ),
                onTap: () async {
                  if (isUnlocked) {
                    encryptionCubit.lock();
                  } else {
                    await showUnlockDialog(context);
                  }
                  if (context.mounted) {
                    BlocProvider.of<NotesFetchCubit>(context).fetchNotes();
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            Material(
              color: Colors.transparent,
              child: SettingsTile(
                child: Text(
                  "Change encryption passphrase",
                  style: TextStyle(fontSize: 16.0, color: mainTextColor),
                ),
                onTap: () => showChangePassphraseDialog(context),
              ),
            ),
          ],
        );
      },
    );
  }
}
