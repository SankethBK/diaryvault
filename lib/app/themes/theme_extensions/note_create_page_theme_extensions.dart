import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class NoteCreatePageThemeExtensions
    extends ThemeExtension<NoteCreatePageThemeExtensions> {
  final Color
      fallbackColor; // fall back color for background till image is loaded
  final Color titleTextBoxFillColor; // fill color for title textbox
  final Color titleTextBoxBorderColor;
  final Color titleTextBoxFocussedBorderColor;
  final Color titlePlaceHolderColor;
  final Color titleTextColor;
  final Color toolbarGradientStartColor;
  final Color toolbarGradientEndColor;
  final QuillIconTheme toolbarTheme;
  final Color richTextGradientStartColor;
  final Color richTextGradientEndColor;
  final Color suffixIconColor; // color of upward aroow in title inpit

  NoteCreatePageThemeExtensions({
    required this.fallbackColor,
    required this.titleTextBoxFillColor,
    required this.titleTextBoxBorderColor,
    required this.titlePlaceHolderColor,
    required this.titleTextColor,
    required this.toolbarGradientStartColor,
    required this.toolbarGradientEndColor,
    required this.toolbarTheme,
    required this.richTextGradientStartColor,
    required this.richTextGradientEndColor,
    required this.titleTextBoxFocussedBorderColor,
    required this.suffixIconColor,
  });

  @override
  ThemeExtension<NoteCreatePageThemeExtensions> copyWith(
      {Color? fallbackColor,
      Color? titleTextBoxFillColor,
      Color? titleTextBoxBorderColor,
      Color? titlePlaceHolderColor,
      Color? titleTextColor,
      Color? toolbarGradientStartColor,
      Color? toolbarGradientEndColor,
      QuillIconTheme? toolbarTheme,
      Color? richTextGradientStartColor,
      Color? richTextGradientEndColor,
      Color? titleTextBoxFocussedBorderColor,
      Color? suffixIconColor}) {
    return NoteCreatePageThemeExtensions(
      fallbackColor: fallbackColor ?? this.fallbackColor,
      titleTextBoxFillColor:
          titleTextBoxFillColor ?? this.titleTextBoxFillColor,
      titleTextBoxBorderColor:
          titleTextBoxBorderColor ?? this.titleTextBoxBorderColor,
      titlePlaceHolderColor:
          titlePlaceHolderColor ?? this.titlePlaceHolderColor,
      titleTextColor: titleTextColor ?? this.titleTextColor,
      toolbarGradientStartColor:
          toolbarGradientStartColor ?? this.toolbarGradientStartColor,
      toolbarGradientEndColor:
          toolbarGradientEndColor ?? this.toolbarGradientEndColor,
      toolbarTheme: toolbarTheme ?? this.toolbarTheme,
      richTextGradientStartColor:
          richTextGradientStartColor ?? this.richTextGradientStartColor,
      richTextGradientEndColor:
          richTextGradientEndColor ?? this.richTextGradientEndColor,
      titleTextBoxFocussedBorderColor: titleTextBoxFocussedBorderColor ??
          this.titleTextBoxFocussedBorderColor,
      suffixIconColor: suffixIconColor ?? this.suffixIconColor,
    );
  }

  @override
  ThemeExtension<NoteCreatePageThemeExtensions> lerp(
      covariant NoteCreatePageThemeExtensions? other, double t) {
    return NoteCreatePageThemeExtensions(
      fallbackColor: Color.lerp(fallbackColor, other?.fallbackColor, t)!,
      titleTextBoxFillColor:
          Color.lerp(titleTextBoxFillColor, other?.titleTextBoxFillColor, t)!,
      titleTextBoxBorderColor: Color.lerp(
          titleTextBoxBorderColor, other?.titleTextBoxBorderColor, t)!,
      titlePlaceHolderColor:
          Color.lerp(titlePlaceHolderColor, other?.titlePlaceHolderColor, t)!,
      titleTextColor: Color.lerp(titleTextColor, other?.titleTextColor, t)!,
      toolbarGradientStartColor: Color.lerp(
          toolbarGradientStartColor, other?.toolbarGradientStartColor, t)!,
      toolbarGradientEndColor: Color.lerp(
          toolbarGradientEndColor, other?.toolbarGradientEndColor, t)!,
      toolbarTheme: toolbarTheme,
      richTextGradientStartColor: Color.lerp(
          richTextGradientStartColor, other?.richTextGradientStartColor, t)!,
      richTextGradientEndColor: Color.lerp(
          richTextGradientEndColor, other?.richTextGradientEndColor, t)!,
      titleTextBoxFocussedBorderColor: Color.lerp(
          titleTextBoxFocussedBorderColor,
          other?.titleTextBoxFocussedBorderColor,
          t)!,
      suffixIconColor: Color.lerp(suffixIconColor, other?.suffixIconColor, t)!,
    );
  }
}
