import 'package:dairy_app/core/constants/exports.dart';

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
        AppLocalizations.of(context).shareWithFriends,
        style: mainTextStyle,
      ),
    );
  }
}
