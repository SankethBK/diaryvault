import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/core/utils/background_image.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_app_bar.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encryption_cubit.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/change_passphrase_dialog.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/encryption_setup_dialog.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/regenerate_recovery_dialog.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Settings page for note encryption. The toggle enables encryption for the
/// first time (full setup flow must complete); once enabled the page offers
/// lock/unlock, passphrase change and recovery code rotation.
class EncryptionSettingsPage extends StatelessWidget {
  static String get route => '/encryption-settings';

  const EncryptionSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundImagePath =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundImage;

    final backgroundColor = Theme.of(context)
        .extension<AuthPageThemeExtensions>()!
        .backgroundColor;

    final richTextGradientStartColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .richTextGradientStartColor;

    final richTextGradientEndColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .richTextGradientEndColor;

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    final inactiveTrackColor = Theme.of(context)
        .extension<SettingsPageThemeExtensions>()!
        .inactiveTrackColor;

    final activeColor =
        Theme.of(context).extension<SettingsPageThemeExtensions>()!.activeColor;

    final encryptionCubit = BlocProvider.of<EncryptionCubit>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Encryption"),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top +
              10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        decoration: getBackgroundDecoration(
          backgroundImagePath,
          backgroundColor: backgroundColor,
        ),
        child: GlassMorphismCover(
          displayShadow: false,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              gradient: LinearGradient(
                colors: [
                  richTextGradientStartColor,
                  richTextGradientEndColor,
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
            child: BlocBuilder<EncryptionCubit, EncryptionSessionState>(
              bloc: encryptionCubit,
              builder: (context, state) {
                final isEnabled = state is! EncryptionDisabled;
                final isUnlocked = state is EncryptionUnlocked;

                return ListView(
                  padding: const EdgeInsets.all(0.0),
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Encrypt sensitive notes with a passphrase only you "
                      "know. Encrypted notes are protected on this device and "
                      "in your cloud backup, and live in a separate locked "
                      "view.",
                      style: TextStyle(fontSize: 13.5, color: mainTextColor),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      inactiveTrackColor: inactiveTrackColor,
                      activeColor: activeColor,
                      contentPadding: const EdgeInsets.all(0.0),
                      title: Text(
                        "Enable note encryption",
                        style: TextStyle(color: mainTextColor),
                      ),
                      subtitle: Text(
                        isEnabled
                            ? "Enabled"
                            : "Set up a passphrase and recovery code",
                        style: TextStyle(color: mainTextColor),
                      ),
                      value: isEnabled,
                      onChanged: (value) async {
                        if (isEnabled) {
                          // Encryption can't be "turned off" for already
                          // encrypted notes; they stay protected and can be
                          // unlocked anytime
                          showToast(
                              "Encryption stays on for encrypted notes. Lock them anytime from the encrypted notes view.");
                          return;
                        }
                        final setupDone =
                            await showEncryptionSetupDialog(context);
                        if (setupDone == true && context.mounted) {
                          showToast("Encryption enabled");
                        }
                      },
                    ),
                    if (isEnabled) ...[
                      const SizedBox(height: 16),
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
                                    ? "Lock encrypted notes"
                                    : "Unlock encrypted notes",
                                style: TextStyle(
                                    fontSize: 16.0, color: mainTextColor),
                              ),
                            ],
                          ),
                          onTap: () async {
                            if (isUnlocked) {
                              encryptionCubit.lock();
                            } else {
                              await showUnlockDialog(context);
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
                            style:
                                TextStyle(fontSize: 16.0, color: mainTextColor),
                          ),
                          onTap: () => showChangePassphraseDialog(context),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Material(
                        color: Colors.transparent,
                        child: SettingsTile(
                          child: Text(
                            "Regenerate recovery code",
                            style:
                                TextStyle(fontSize: 16.0, color: mainTextColor),
                          ),
                          onTap: () => showRegenerateRecoveryDialog(context),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
