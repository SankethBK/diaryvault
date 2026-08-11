part of 'theme_cubit.dart';

enum Themes {
  coralBubbles,
  cosmic,
  lushGreen,
  twilightGold,
  custom
}

String themeKey = "current_theme";
String customThemeConfigKey = "custom_theme_config";
String customThemesKey = "custom_themes";

extension ThemeExtension on Themes {
  String enumToStr() {
    switch (this) {
      case Themes.coralBubbles:
        return 'Coral Bubbles';
      case Themes.cosmic:
        return 'Cosmic';
      case Themes.lushGreen:
        return 'Lush Green';
      case Themes.twilightGold:
        return "Twilight Gold";
      case Themes.custom:
        return "Custom";
    }
  }
}

Themes getThemeFromString(String? themeString) {
  switch (themeString) {
    case 'coralBubbles':
      return Themes.coralBubbles;
    case 'cosmic':
      return Themes.cosmic;
    case 'lushGreen':
      return Themes.lushGreen;
    case 'twilightGold':
      return Themes.twilightGold;
    case 'custom':
      return Themes.custom;
    default:
      return Themes.coralBubbles;
  }
}

abstract class ThemeState extends Equatable {
  final Themes theme;

  /// Active custom theme config, present only when [theme] is [Themes.custom]
  final CustomThemeConfig? customConfig;

  /// All saved custom themes
  final List<CustomThemeConfig> customThemes;

  const ThemeState(
      {required this.theme,
      this.customConfig,
      this.customThemes = const []});

  @override
  List<Object> get props => [
        theme.toString(),
        customConfig?.encode() ?? "",
        customThemes.map((t) => t.encode()).join("|")
      ];
}

class ThemeChanged extends ThemeState {
  const ThemeChanged(
      {required Themes theme,
      CustomThemeConfig? customConfig,
      List<CustomThemeConfig> customThemes = const []})
      : super(
            theme: theme,
            customConfig: customConfig,
            customThemes: customThemes);
}
