part of 'theme_cubit.dart';

enum Themes { coralBubbles, cosmic, lushGreen, plainDark, darkAcademia }

String themeKey = "current_theme";

extension ThemeExtension on Themes {
  String enumToStr() {
    switch (this) {
      case Themes.coralBubbles:
        return 'Coral Bubbles';
      case Themes.cosmic:
        return 'Cosmic';
      case Themes.lushGreen:
        return 'Lush Green';
      case Themes.plainDark:
        return "Plain Dark";
      case Themes.darkAcademia:
        return "Dark Academia";
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
    case 'plainDark':
      return Themes.plainDark;
    default:
      return Themes.coralBubbles;
  }
}

abstract class ThemeState extends Equatable {
  final Themes theme;
  const ThemeState({required this.theme});

  @override
  List<Object> get props => [theme.toString()];
}

class ThemeChanged extends ThemeState {
  const ThemeChanged({required Themes theme}) : super(theme: theme);
}
