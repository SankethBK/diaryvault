import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SendFeedBack extends StatelessWidget {
  const SendFeedBack({Key? key}) : super(key: key);

  final emailAddress = 'diaryvault.app@gmail.com';
  final subject = 'Feedback for DiaryVault';

  @override
  Widget build(BuildContext context) => SettingsTile(
        onTap: _launchEmailApp,
        child: Text(
          "Send feedback",
          style: TextStyle(
            fontSize: 16.0,
            color: Theme.of(context)
                .extension<NoteCreatePageThemeExtensions>()!
                .mainTextColor,
          ),
        ),
      );

  void _launchEmailApp() async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: emailAddress,
        queryParameters: {'subject': subject},
      );

      await launchUrl(emailLaunchUri);
    } catch (e) {
      throw Exception(
        "Error sending feed-back",
      );
    }
  }
}
