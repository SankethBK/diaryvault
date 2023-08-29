import 'package:flutter/material.dart';

class AppbarThemeExtensions extends ThemeExtension<AppbarThemeExtensions> {
  final Color iconColor;
  final Color appBarGradientStartColor;
  final Color appBarGradientEndColor;
  final Color
      searchBarFillColor; // fill color for search bar in home page appbar

  AppbarThemeExtensions({
    required this.iconColor,
    required this.appBarGradientStartColor,
    required this.appBarGradientEndColor,
    required this.searchBarFillColor,
  });

  @override
  ThemeExtension<AppbarThemeExtensions> copyWith({
    Color? iconColor,
    Color? appBarGradientStartColor,
    Color? appBarGradientEndColor,
    Color? searchBarFillColor,
  }) {
    return AppbarThemeExtensions(
      iconColor: iconColor ?? this.iconColor,
      appBarGradientStartColor:
          appBarGradientStartColor ?? this.appBarGradientStartColor,
      appBarGradientEndColor:
          appBarGradientEndColor ?? this.appBarGradientEndColor,
      searchBarFillColor: this.searchBarFillColor,
    );
  }

  @override
  ThemeExtension<AppbarThemeExtensions> lerp(
    covariant AppbarThemeExtensions? other,
    double t,
  ) {
    return AppbarThemeExtensions(
      iconColor: Color.lerp(iconColor, other?.iconColor, t)!,
      appBarGradientStartColor: Color.lerp(
          appBarGradientStartColor, other?.appBarGradientStartColor, t)!,
      appBarGradientEndColor:
          Color.lerp(appBarGradientEndColor, other?.appBarGradientEndColor, t)!,
      searchBarFillColor:
          Color.lerp(searchBarFillColor, other?.searchBarFillColor, t)!,
    );
  }
}
