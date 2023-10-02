import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/glass_app_bar.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/logout_button.dart';
import 'package:dairy_app/core/widgets/send_feedback.dart';
import 'package:dairy_app/core/widgets/share_with_friends.dart';
import 'package:dairy_app/core/widgets/theme_dropdown.dart';
import 'package:dairy_app/core/widgets/version_number.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/widgets/security_settings.dart';
import 'package:dairy_app/features/auth/presentation/widgets/setup_account.dart';
import 'package:dairy_app/features/sync/presentation/widgets/sync_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/auto_save_enable.dart';

class SettingsPage extends StatefulWidget {
  static String get route => '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Image neonImage;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final backgroundImagePath = Theme.of(context)
          .extension<AuthPageThemeExtensions>()!
          .backgroundImage;

      neonImage = Image.asset(backgroundImagePath);
      precacheImage(neonImage.image, context);

      _isInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authSessionBloc = BlocProvider.of<AuthSessionBloc>(context);
    final backgroundImagePath =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundImage;

    final richTextGradientStartColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .richTextGradientStartColor;

    final richTextGradientEndColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .richTextGradientEndColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Settings"),
        actions: [LogoutButton(authSessionBloc: authSessionBloc)],
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              backgroundImagePath,
            ),
            fit: BoxFit.cover,
            alignment: const Alignment(0.725, 0.1),
          ),
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
            child: ListView(
              padding: const EdgeInsets.all(0.0),
              children: [
                const SetupAccount(),
                const SyncSettings(),
                const SizedBox(height: 25.0),
                SecuritySettings(),
                const SizedBox(height: 15),
                const AutoSaveToggleButton(),
                const SizedBox(height: 15),
                const ThemeDropdown(),
                const SizedBox(height: 15),
                const SendFeedBack(),
                const SizedBox(height: 15),
                const ShareWithFriends(),
                const SizedBox(height: 15),
                const VersionNumber(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
