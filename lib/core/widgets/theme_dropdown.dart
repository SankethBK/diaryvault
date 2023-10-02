import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeDropdown extends StatelessWidget {
  const ThemeDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);

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
        DropdownButton<Themes>(
          padding: const EdgeInsets.only(bottom: 0.0),
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
          value: themeCubit.state.theme,
          onChanged: (value) async {
            // Update the selected value
            await themeCubit.setTheme(value);
          },
          items: Themes.values.map((item) {
            return DropdownMenuItem<Themes>(
              value: item,
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
