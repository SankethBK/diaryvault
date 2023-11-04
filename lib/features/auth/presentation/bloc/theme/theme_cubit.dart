import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final IKeyValueDataSource keyValueDataSource;

  ThemeCubit({required this.keyValueDataSource})
      : super(const ThemeChanged(theme: Themes.cosmic)) {
    final currentTheme =
        getThemeFromString(keyValueDataSource.getValue(themeKey));

    emit(ThemeChanged(theme: currentTheme));
  }

  setTheme(Themes? theme) async {
    if (theme != null) {
      await keyValueDataSource.setValue(
          themeKey, theme.toString().substring(7));

      emit(ThemeChanged(theme: theme));
    }
  }
}
