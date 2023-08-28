import 'package:flutter/material.dart';

class AppbarThemeExtensions extends ThemeExtension<AppbarThemeExtensions> {
  final Color iconColor;
  final Color appBarGradientStartColor;
  final Color appBarGradientEndColor;

  AppbarThemeExtensions({
    required this.iconColor,
    required this.appBarGradientStartColor,
    required this.appBarGradientEndColor,
  });

  @override
  ThemeExtension<AppbarThemeExtensions> copyWith({
    Color? iconColor,
    Color? appBarGradientStartColor,
    Color? appBarGradientEndColor,
  }) {
    return AppbarThemeExtensions(
      iconColor: iconColor ?? this.iconColor,
      appBarGradientStartColor:
          appBarGradientStartColor ?? this.appBarGradientStartColor,
      appBarGradientEndColor:
          appBarGradientEndColor ?? this.appBarGradientEndColor,
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
    );
  }
}
