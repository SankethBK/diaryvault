import 'dart:ui';

import 'package:flutter/material.dart';

class HomePageThemeExtensions extends ThemeExtension<HomePageThemeExtensions> {
  final Color borderColor; // border color for home page background
  final Color
      backgroundGradientStartColor; // start color of home page background gradient
  final Color
      backgroundGradientEndColor; // end color of home page background gradient
  final Color previewTitleColor; // text color for note title
  final Color previewBodyColor; // text color for preview body
  final Color dateColor; // text color for date in notes preview
  final double sigmaX; // blurness for glass pane in home screen
  final double sigmaY;
  final Color notePreviewBorderColor; // border color for note preview card
  final Color
      notePreviewUnselectedGradientStartColor; // gradient colors for note preview card in unselected state
  final Color notePreviewUnselectedGradientEndColor;
  final Color
      notePreviewSelectedGradientStartColor; // gradient colors for note preview card in selected state
  final Color notePreviewSelectedGradientEndColor;
  final Color checkBoxSelectedColor; // color of checkbox when its selected

  HomePageThemeExtensions({
    required this.borderColor,
    required this.backgroundGradientStartColor,
    required this.backgroundGradientEndColor,
    required this.previewTitleColor,
    required this.previewBodyColor,
    required this.dateColor,
    required this.sigmaX,
    required this.sigmaY,
    required this.notePreviewBorderColor,
    required this.notePreviewUnselectedGradientStartColor,
    required this.notePreviewUnselectedGradientEndColor,
    required this.notePreviewSelectedGradientStartColor,
    required this.notePreviewSelectedGradientEndColor,
    required this.checkBoxSelectedColor,
  });

  @override
  ThemeExtension<HomePageThemeExtensions> copyWith({
    Color? borderColor,
    Color? backgroundGradientStartColor,
    Color? backgroundGradientEndColor,
    Color? previewTitleColor,
    Color? previewBodyColor,
    Color? dateColor,
    double? sigmaX,
    double? sigmaY,
    Color? notePreviewBorderColor,
    Color? notePreviewUnselectedGradientStartColor,
    Color? notePreviewUnselectedGradientEndColor,
    Color? notePreviewSelectedGradientStartColor,
    Color? notePreviewSelectedGradientEndColor,
    Color? checkBoxSelectedColor,
  }) {
    return HomePageThemeExtensions(
      borderColor: borderColor ?? this.borderColor,
      backgroundGradientStartColor:
          backgroundGradientStartColor ?? this.backgroundGradientStartColor,
      backgroundGradientEndColor:
          backgroundGradientEndColor ?? this.backgroundGradientEndColor,
      previewTitleColor: previewTitleColor ?? this.previewTitleColor,
      previewBodyColor: previewBodyColor ?? this.previewBodyColor,
      dateColor: dateColor ?? this.dateColor,
      sigmaX: sigmaX ?? this.sigmaX,
      sigmaY: sigmaY ?? this.sigmaY,
      notePreviewBorderColor:
          notePreviewBorderColor ?? this.notePreviewBorderColor,
      notePreviewUnselectedGradientStartColor:
          this.notePreviewUnselectedGradientStartColor,
      notePreviewUnselectedGradientEndColor:
          this.notePreviewUnselectedGradientEndColor,
      notePreviewSelectedGradientStartColor:
          this.notePreviewSelectedGradientStartColor,
      notePreviewSelectedGradientEndColor:
          this.notePreviewSelectedGradientEndColor,
      checkBoxSelectedColor: this.checkBoxSelectedColor,
    );
  }

  @override
  ThemeExtension<HomePageThemeExtensions> lerp(
      covariant HomePageThemeExtensions? other, double t) {
    return HomePageThemeExtensions(
      borderColor: Color.lerp(borderColor, other?.borderColor, t)!,
      backgroundGradientStartColor: Color.lerp(backgroundGradientStartColor,
          other?.backgroundGradientStartColor, t)!,
      backgroundGradientEndColor: Color.lerp(
          backgroundGradientEndColor, other?.backgroundGradientEndColor, t)!,
      previewTitleColor:
          Color.lerp(previewTitleColor, other?.previewTitleColor, t)!,
      previewBodyColor:
          Color.lerp(previewBodyColor, other?.previewBodyColor, t)!,
      dateColor: Color.lerp(dateColor, other?.dateColor, t)!,
      sigmaX: lerpDouble(sigmaX, other?.sigmaX, t)!,
      sigmaY: lerpDouble(sigmaY, other?.sigmaY, t)!,
      notePreviewBorderColor:
          Color.lerp(notePreviewBorderColor, other?.notePreviewBorderColor, t)!,
      notePreviewUnselectedGradientStartColor: Color.lerp(
          notePreviewUnselectedGradientStartColor,
          other?.notePreviewUnselectedGradientStartColor,
          t)!,
      notePreviewUnselectedGradientEndColor: Color.lerp(
          notePreviewUnselectedGradientEndColor,
          other?.notePreviewUnselectedGradientEndColor,
          t)!,
      notePreviewSelectedGradientStartColor: Color.lerp(
          notePreviewSelectedGradientStartColor,
          other?.notePreviewSelectedGradientStartColor,
          t)!,
      notePreviewSelectedGradientEndColor: Color.lerp(
          notePreviewSelectedGradientEndColor,
          other?.notePreviewSelectedGradientEndColor,
          t)!,
      checkBoxSelectedColor:
          Color.lerp(checkBoxSelectedColor, other?.checkBoxSelectedColor, t)!,
    );
  }
}
