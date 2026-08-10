import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dairy_app/app/themes/custom_theme/custom_theme_config.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final IKeyValueDataSource keyValueDataSource;

  ThemeCubit({required this.keyValueDataSource})
      : super(const ThemeChanged(theme: Themes.cosmic)) {
    final currentTheme =
        getThemeFromString(keyValueDataSource.getValue(themeKey));

    final customConfig = CustomThemeConfig.tryDecode(
        keyValueDataSource.getValue(customThemeConfigKey));

    emit(ThemeChanged(
        theme: currentTheme == Themes.custom && customConfig == null
            ? Themes.cosmic
            : currentTheme,
        customConfig: customConfig,
        customThemes: _loadCustomThemes(customConfig)));
  }

  List<CustomThemeConfig> _loadCustomThemes(CustomThemeConfig? activeConfig) {
    final raw = keyValueDataSource.getValue(customThemesKey);

    if (raw == null || raw.isEmpty) {
      // migrate: seed the list with the legacy single custom theme
      return activeConfig != null ? [activeConfig] : [];
    }

    try {
      return (jsonDecode(raw) as List)
          .map((e) => CustomThemeConfig.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return activeConfig != null ? [activeConfig] : [];
    }
  }

  Future<void> _persistCustomThemes(List<CustomThemeConfig> themes) async {
    await keyValueDataSource.setValue(customThemesKey,
        jsonEncode(themes.map((t) => t.toJson()).toList()));
  }

  setTheme(Themes? theme) async {
    if (theme != null) {
      await keyValueDataSource.setValue(
          themeKey, theme.toString().substring(7));

      emit(ThemeChanged(
          theme: theme,
          customConfig: state.customConfig,
          customThemes: state.customThemes));
    }
  }

  /// Creates or updates a custom theme and activates it
  saveCustomTheme(CustomThemeConfig config) async {
    final themes = [...state.customThemes];
    final index = themes.indexWhere((t) => t.id == config.id);
    if (index >= 0) {
      themes[index] = config;
    } else {
      themes.add(config);
    }

    await _persistCustomThemes(themes);
    await keyValueDataSource.setValue(customThemeConfigKey, config.encode());
    await keyValueDataSource.setValue(themeKey, 'custom');

    emit(ThemeChanged(
        theme: Themes.custom, customConfig: config, customThemes: themes));
  }

  /// Activates an already saved custom theme
  applyCustomTheme(CustomThemeConfig config) async {
    await keyValueDataSource.setValue(customThemeConfigKey, config.encode());
    await keyValueDataSource.setValue(themeKey, 'custom');

    emit(ThemeChanged(
        theme: Themes.custom,
        customConfig: config,
        customThemes: state.customThemes));
  }

  deleteCustomTheme(String id) async {
    final themes = state.customThemes.where((t) => t.id != id).toList();
    await _persistCustomThemes(themes);

    if (state.customConfig?.id == id) {
      // active theme was deleted, fall back to default
      await keyValueDataSource.setValue(themeKey, 'cosmic');
      emit(ThemeChanged(
          theme: Themes.cosmic, customConfig: null, customThemes: themes));
    } else {
      emit(ThemeChanged(
          theme: state.theme,
          customConfig: state.customConfig,
          customThemes: themes));
    }
  }
}
