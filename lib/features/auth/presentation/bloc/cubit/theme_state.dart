part of 'theme_cubit.dart';

enum Themes {
  coralBubbles,
  cosmic,
}

String themeKey = "current_theme";

extension ThemeExtension on Themes {
  String enumToStr() {
    switch (this) {
      case Themes.coralBubbles:
        return 'Coral Bubbles';
      case Themes.cosmic:
        return 'Cosmic';
    }
  }
}

Themes getThemeFromString(String? themeString) {
  switch (themeString) {
    case 'coralBubbles':
      return Themes.coralBubbles;
    case 'cosmic':
      return Themes.cosmic;
    default:
      return Themes.cosmic;
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
