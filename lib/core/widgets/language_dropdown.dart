import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/locale/language_locale.dart';
import 'package:dairy_app/features/auth/presentation/bloc/locale/locale_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeCubit = BlocProvider.of<LocaleCubit>(context);

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              S.current.appLanguage,
              style: TextStyle(
                fontSize: 16.0,
                color: mainTextColor,
              ),
            ),
          ),
          PopupMenuButton<Locale>(
            itemBuilder: (context) {
              return S.delegate.supportedLocales.map((Locale locale) {
                return PopupMenuItem(
                  value: locale,
                  child: Text(
                    LanguageLocal
                        .isoLangs[locale.toLanguageTag()]!["nativeName"]!,
                    style: TextStyle(
                      color: mainTextColor,
                    ),
                  ),
                );
              }).toList();
            },
            padding: const EdgeInsets.only(bottom: 0.0),
            onSelected: (value) async {
              // Update the selected value
              await localeCubit.setLocale(value);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  LanguageLocal.isoLangs[localeCubit.state.currentLocale
                      .toLanguageTag()]!["nativeName"]!,
                  style: TextStyle(
                    color: mainTextColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.keyboard_arrow_down,color: mainTextColor,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
