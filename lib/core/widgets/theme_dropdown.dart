import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';

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
          AppLocalizations.of(context).chooseTheme,
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
