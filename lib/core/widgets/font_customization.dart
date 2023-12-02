import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/font/font_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FontCustomization extends StatelessWidget {
  const FontCustomization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontCubit = BlocProvider.of<FontCubit>(context);
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;
    final dropDownBackgroundColor = Theme.of(context)
        .extension<SettingsPageThemeExtensions>()!
        .dropDownBackgroundColor;

    return BlocBuilder<FontCubit, FontState>(builder: (context, state) {
      return Row(
        children: [
          Expanded(
            child: Text(
              S.current.fontFamily,
              style: TextStyle(
                fontSize: 16.0,
                color: mainTextColor,
              ),
            ),
          ),
          DropdownButton<FontFamily>(
            value: state.currentFontFamily,
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
            items: FontFamily.values
                .map(
                  (fontFamily) => DropdownMenuItem<FontFamily>(
                    child: Text(
                      fontFamily.text,
                      style: fontFamily
                          .getGoogleFontFamilyTextStyle(mainTextColor),
                    ),
                    value: fontFamily,
                  ),
                )
                .toList(),
            onChanged: (value) async {
              await fontCubit.setFontFamily(value!);
            },
          )
        ],
      );
    });
  }
}
