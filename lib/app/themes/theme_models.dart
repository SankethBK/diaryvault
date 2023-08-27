import 'package:flutter/material.dart';

class AdditionalThemeExtensions
    extends ThemeExtension<AdditionalThemeExtensions> {
  final String backgroundImage; // path for background image
  final Color linkColor; // color for clickable links (in auth page)
  final Color errorTextColor; // color for error messages in auth page

  AdditionalThemeExtensions(
      {required this.linkColor,
      required this.backgroundImage,
      required this.errorTextColor});

  @override
  ThemeExtension<AdditionalThemeExtensions> copyWith(
      {String? backgroundImage, Color? linkColor, Color? errorTextColor}) {
    return AdditionalThemeExtensions(
      backgroundImage: backgroundImage ?? this.backgroundImage,
      linkColor: linkColor ?? this.linkColor,
      errorTextColor: errorTextColor ?? this.errorTextColor,
    );
  }

  @override
  ThemeExtension<AdditionalThemeExtensions> lerp(
      covariant ThemeExtension<AdditionalThemeExtensions>? other, double t) {
    return AdditionalThemeExtensions(
        backgroundImage: backgroundImage,
        linkColor: linkColor,
        errorTextColor: errorTextColor);
  }
}
