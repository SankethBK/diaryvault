import 'package:dairy_app/app/themes/font.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FontCustomization extends StatelessWidget {
  const FontCustomization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;
    final dropDownBackgroundColor = Theme.of(context)
        .extension<SettingsPageThemeExtensions>()!
        .dropDownBackgroundColor;
    final fontFamilyMap = getFontFamilyMaps();

    return BlocBuilder<UserConfigCubit, UserConfigState>(
        builder: (context, state) {
      return Row(
        children: [
          Expanded(
            child: Text(
              "Font Family",
              style: TextStyle(
                fontSize: 16.0,
                color: mainTextColor,
              ),
            ),
          ),
          DropdownButton<String>(
            value: state.userConfigModel?.preferredFontFamily ?? "san-serif",
            padding: const EdgeInsets.only(bottom: 5.0),
            iconEnabledColor: mainTextColor,
            dropdownColor: dropDownBackgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            focusColor: mainTextColor,
            underline: Container(
              height: 1,
              color: mainTextColor,
            ),
            items: fontFamilyMap.entries
                .map((e) => DropdownMenuItem<String>(
                    child: Text(
                      e.key,
                      style: TextStyle(color: mainTextColor),
                    ),
                    value: e.value))
                .toList(),
            onChanged: (value) async {
              await userConfigCubit.setUserConfig(
                  UserConfigConstants.preferredFontFamily, value);
            },
          )
        ],
      );
    });
  }
}
