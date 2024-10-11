import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectOnGithub extends StatelessWidget {
  const ProjectOnGithub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainTextStyle = TextStyle(
      fontSize: 16.0,
      color: Theme.of(context)
          .extension<NoteCreatePageThemeExtensions>()!
          .mainTextColor,
    );

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return SettingsTile(
      onTap: (() async {
        final githubUrl = Uri.parse('https://github.com/SankethBK/diaryvault');
        await launchUrl(githubUrl);
      }),
      child: Row(
        children: [
          Text(
            S.current.projectOnGithub,
            style: mainTextStyle,
          ),
          const Spacer(),
          SizedBox(
            height: 25,
            width: 25,
            child: Image.asset(
              "assets/images/github-logo.webp",
              color: mainTextColor,
            ),
          )
        ],
      ),
    );
  }
}
