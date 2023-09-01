import 'package:flutter/material.dart';

class PopupThemeExtensions extends ThemeExtension<PopupThemeExtensions> {
  final Color barrierColor;
  final Color popupGradientStartColor;
  final Color popupGradientEndColor;
  final Color mainTextColor;

  PopupThemeExtensions({
    required this.barrierColor,
    required this.popupGradientStartColor,
    required this.popupGradientEndColor,
    required this.mainTextColor,
  });

  @override
  ThemeExtension<PopupThemeExtensions> copyWith({
    Color? barrierColor,
    Color? popupGradientStartColor,
    Color? popupGradientEndColor,
    Color? mainTextColor,
  }) {
    return PopupThemeExtensions(
      barrierColor: barrierColor ?? this.barrierColor,
      popupGradientStartColor:
          popupGradientStartColor ?? this.popupGradientStartColor,
      popupGradientEndColor:
          popupGradientEndColor ?? this.popupGradientEndColor,
      mainTextColor: mainTextColor ?? this.mainTextColor,
    );
  }

  @override
  ThemeExtension<PopupThemeExtensions> lerp(
      covariant PopupThemeExtensions? other, double t) {
    return PopupThemeExtensions(
      barrierColor: Color.lerp(barrierColor, other?.barrierColor, t)!,
      popupGradientStartColor: Color.lerp(
          popupGradientStartColor, other?.popupGradientStartColor, t)!,
      popupGradientEndColor:
          Color.lerp(popupGradientEndColor, other?.popupGradientEndColor, t)!,
      mainTextColor: Color.lerp(mainTextColor, other?.mainTextColor, t)!,
    );
  }
}
