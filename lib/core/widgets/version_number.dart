import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
                "App version",
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
