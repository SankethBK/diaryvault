import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitWebsite extends StatelessWidget {
  const VisitWebsite({Key? key}) : super(key: key);

  static const String url = "https://sankethbk.github.io/diaryvault/";

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;
    final mainTextStyle = TextStyle(fontSize: 16.0, color: mainTextColor);

    return SettingsTile(
      onTap: () async {
        await launchUrl(Uri.parse(url));
      },
      child: Row(
        children: [
          Text(
            S.current.visitWebsite,
            style: mainTextStyle,
          ),
          const Spacer(),
          Icon(
            Icons.open_in_new,
            color: mainTextColor,
          ),
        ],
      ),
    );
  }
}
