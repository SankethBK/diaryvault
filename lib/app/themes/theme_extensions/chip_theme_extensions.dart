import 'package:flutter/material.dart';

class ChipThemeExtensions extends ThemeExtension<ChipThemeExtensions> {
  final Color backgroundColor;
  final Color deleteIconColor;
  final Color textColor;

  ChipThemeExtensions({
    required this.backgroundColor,
    required this.deleteIconColor,
    required this.textColor,
  });

  @override
  ThemeExtension<ChipThemeExtensions> copyWith({
    Color? backgroundColor,
    Color? deleteIconColor,
    Color? textColor,
  }) {
    return ChipThemeExtensions(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      deleteIconColor: deleteIconColor ?? this.deleteIconColor,
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
      deleteIconColor: Color.lerp(deleteIconColor, other?.deleteIconColor, t)!,
      textColor: Color.lerp(textColor, other?.textColor, t)!,
    );
  }
}
