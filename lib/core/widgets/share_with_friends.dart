import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareWithFriends extends StatelessWidget {
  const ShareWithFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainTextStyle = TextStyle(
      fontSize: 16.0,
      color: Theme.of(context)
          .extension<NoteCreatePageThemeExtensions>()!
          .mainTextColor,
    );
    const appDescription =
        "Discover diaryVault - a diary app designed to help you capture your thoughts, memories, and moments effortlessly. Available now on the Play Store!";

    return SettingsTile(
      onTap: (() async {
        try {
          const playstoreURL =
              'https://play.google.com/store/apps/details?id=me.sankethbk.dairyapp';
          await Share.share('$appDescription\n\n$playstoreURL');
        } catch (e) {
          throw Exception(
            "Error sharing app",
          );
        }
      }),
      child: Text(
        "Share with Friends",
        style: mainTextStyle,
      ),
    );
  }
}
