import 'package:dairy_app/core/constants/exports.dart';

class VersionNumber extends StatelessWidget {
  const VersionNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainTextStyle = TextStyle(
      fontSize: 16.0,
      color: Theme.of(context)
          .extension<NoteCreatePageThemeExtensions>()!
          .mainTextColor,
    );

    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.data?.version ?? '';

        return SettingsTile(
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context).appVersion,
                style: mainTextStyle,
              ),
              const Spacer(),
              Text(
                version,
                style: mainTextStyle,
              ),
            ],
          ),
        );
      },
    );
  }
}
