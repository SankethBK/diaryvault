import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/font/font_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FontDropdown extends StatelessWidget {
  const FontDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontCubit = BlocProvider.of<FontCubit>(context);

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

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
          PopupMenuButton<FontFamily>(
            padding: const EdgeInsets.only(bottom: 5.0),
            itemBuilder: (context) => FontFamily.values
                .map(
                  (fontFamily) => PopupMenuItem<FontFamily>(
                    child: Text(fontFamily.text,
                        style: fontFamily
                            .getGoogleFontFamilyTextStyle(mainTextColor)),
                    value: fontFamily,
                  ),
                )
                .toList(),
            onSelected: (value) async {
              await fontCubit.setFontFamily(value);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  fontCubit.state.currentFontFamily.text,
                  style: TextStyle(
                    color: mainTextColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: mainTextColor,
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
