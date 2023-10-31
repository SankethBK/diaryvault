import 'package:flutter/material.dart';

class ChipThemeExtensions extends ThemeExtension<ChipThemeExtensions> {
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  ChipThemeExtensions({
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  ThemeExtension<ChipThemeExtensions> copyWith({
    Color? backgroundColor,
    Color? iconColor,
    Color? textColor,
  }) {
    return ChipThemeExtensions(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      textColor: textColor ?? this.textColor,
    );
  }

  @override
  ThemeExtension<ChipThemeExtensions> lerp(
    covariant ChipThemeExtensions? other,
    double t,
  ) {
    return ChipThemeExtensions(
      backgroundColor: Color.lerp(backgroundColor, other?.backgroundColor, t)!,
      iconColor: Color.lerp(iconColor, other?.iconColor, t)!,
      textColor: Color.lerp(textColor, other?.textColor, t)!,
    );
  }
}
