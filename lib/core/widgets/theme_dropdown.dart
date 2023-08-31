import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeDropdown extends StatelessWidget {
  const ThemeDropdown({Key? key}) : super(key: key);

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
        Text(
          "Choose Theme",
          style: TextStyle(
            fontSize: 16.0,
            color: mainTextColor,
          ),
        ),
        const Spacer(),
        DropdownButton<String>(
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
          value: userConfigCubit.state.userConfigModel?.currentTheme
                  ?.toString()
                  .substring(7) ??
              Themes.cosmic.toString().substring(7),
          onChanged: (newValue) {
            // Update the selected value
            userConfigCubit.setUserConfig(
                UserConfigConstants.currentTheme, newValue);
          },
          items: Themes.values.map((item) {
            return DropdownMenuItem<String>(
              value: item.toString().substring(7),
              child: Text(
                item.enumToStr(),
                style: TextStyle(color: mainTextColor),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
