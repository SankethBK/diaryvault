import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/themes/theme_extensions/settings_page_theme_extensions.dart';
import '../../features/auth/core/constants.dart';
import '../../features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import '../utils/utils.dart';

class AutoSaveToggleButton extends StatelessWidget {
  const AutoSaveToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inactiveTrackColor = Theme.of(context)
        .extension<SettingsPageThemeExtensions>()!
        .inactiveTrackColor;

    final activeColor =
        Theme.of(context).extension<SettingsPageThemeExtensions>()!.activeColor;

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);

    return BlocBuilder<UserConfigCubit, UserConfigState>(
      builder: (context, state) {
        var isAutoSaveEnabled = state.userConfigModel!.isAutoSaveEnabled;
        return SwitchListTile(
          inactiveTrackColor: inactiveTrackColor,
          activeColor: activeColor,
          contentPadding: const EdgeInsets.all(0.0),
          title: Text(
            "Enable Auto Save",
            style: TextStyle(color: mainTextColor),
          ),
          value: isAutoSaveEnabled ?? false,
          onChanged: (value) async {
            try {
              userConfigCubit.setUserConfig(
                UserConfigConstants.isAutoSaveEnabled,
                value,
              );
            } on Exception catch (e) {
              showToast(e.toString().replaceAll("Exception: ", ""));
            }
          },
        );
      },
    );
  }
}
