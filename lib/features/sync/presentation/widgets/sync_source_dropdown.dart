import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dairy_app/generated/l10n.dart';

class SyncSourceDropdown extends StatelessWidget {
  const SyncSourceDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    final dropDownBackgroundColor = Theme.of(context)
        .extension<SettingsPageThemeExtensions>()!
        .dropDownBackgroundColor;

    return Row(
      children: [
        Expanded(
          child: Text(
            S.current.chooseTheSyncSource,
            style: TextStyle(
              fontSize: 16.0,
              color: mainTextColor,
            ),
          ),
        ),
        BlocBuilder<UserConfigCubit, UserConfigState>(
          builder: (context, state) {
            return DropdownButton<String>(
              padding: const EdgeInsets.only(bottom: 5.0),
              iconEnabledColor: mainTextColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              focusColor: mainTextColor,
              underline: Container(
                height: 1,
                color: mainTextColor,
              ),
              dropdownColor: dropDownBackgroundColor,
              value: state.userConfigModel?.preferredSyncOption ?? "None",
              onChanged: (value) async {
                // Update the selected value
                await userConfigCubit.setUserConfig(
                    UserConfigConstants.preferredSyncOption, value);
              },
              items: [SyncConstants.googleDrive, SyncConstants.dropbox, "None"]
                  .map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(color: mainTextColor),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
