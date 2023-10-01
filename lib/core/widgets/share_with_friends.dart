import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
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
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return GestureDetector(
      onTap: (() async {
        try {
          const playstoreURL =
              'https://play.google.com/store/apps/details?id=me.sankethbk.dairyapp';
          await Share.share(playstoreURL);
        } catch (e) {
          throw Exception("Error sharing app");
        }
      }),
      child: Row(
        children: [
          Icon(
            Icons.share,
            color: mainTextColor,
          ),
          const SizedBox(width: 10.0),
          Text("Share with Friends", style: mainTextStyle),
        ],
      ),
    );
  }
}
