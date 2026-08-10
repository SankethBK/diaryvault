import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/theme/theme_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
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

    return Row(
      children: [
        Text(
          S.current.chooseTheme,
          style: TextStyle(
            fontSize: 16.0,
            color: mainTextColor,
          ),
        ),
        const Spacer(),
        PopupMenuButton<Themes>(
          padding: const EdgeInsets.only(bottom: 0.0),
          onSelected: (value) async {
            // Update the selected value
            await themeCubit.setTheme(value);
          },
          itemBuilder: (context) => [
            ...Themes.values
                .where((item) => item != Themes.custom)
                .map((item) => PopupMenuItem<Themes>(
                      value: item,
                      child: Text(
                        item.enumToStr(),
                        style: TextStyle(color: mainTextColor),
                      ),
                    )),
            // saved custom theme, selectable once it exists
            if (themeCubit.state.customConfig != null)
              PopupMenuItem<Themes>(
                value: Themes.custom,
                child: Text(
                  themeCubit.state.customConfig!.name,
                  style: TextStyle(color: mainTextColor),
                ),
              ),
          ],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                themeCubit.state.theme.enumToStr(),
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
        ),
      ],
    );
  }
}
