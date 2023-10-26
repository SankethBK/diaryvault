import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_accordion/widgets/AccordionHeaderItem.dart';
import 'package:simple_accordion/widgets/AccordionItem.dart';
import 'package:simple_accordion/widgets/AccordionWidget.dart';
import '../../app/themes/font.dart';
import '../../app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import '../../app/themes/theme_extensions/settings_page_theme_extensions.dart';

class FontCustomization extends StatelessWidget{
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
    final fontSizeMap = getFontSizeMaps();
    final fontFamilyMap = getFontFamilyMaps();

    return BlocBuilder<UserConfigCubit, UserConfigState>(
      builder: (context, state) {
      return SimpleAccordion(
          headerColor: mainTextColor,
          headerTextStyle: TextStyle(
            color: mainTextColor,
            fontSize: 16,
          ),
          children: [
        AccordionHeaderItem(title: "Font customization",children: [
          AccordionItem(
            itemTextStyle: TextStyle(
              color: mainTextColor,
              fontSize: 16,
            ),
            child:
            Row(
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
              await userConfigCubit.setUserConfig(UserConfigConstants.preferredFontFamily, value);
            },
          )
                ])),
          AccordionItem(
              itemTextStyle: TextStyle(
                color: mainTextColor,
                fontSize: 16,
              ),
              child:
              Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Font Size",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: mainTextColor,
                        ),
                      ),
                    ),
                    DropdownButton<double>(
                      value: state.userConfigModel?.preferredFontSize ?? fontSizeMap['small'],
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
                      items: fontSizeMap.entries
                          .map((e) => DropdownMenuItem<double>(
                              child: Text(
                                e.key.toString(),
                                style: TextStyle(color: mainTextColor),
                              ),
                              value: e.value))
                          .toList(),
                      onChanged: (value) async {
                        await userConfigCubit.setUserConfig(UserConfigConstants.preferredFontSize, value);
                      },
                    )
                  ]))
        ])
      ]);
    }
    );
  }

}