import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class CoralBubble {
  static ThemeData getTheme() {
    return ThemeData(
      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
        secondary: Colors.pinkAccent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.pink[300],
          backgroundColor: Colors.purple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.purple,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.purple,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.pinkAccent,
        elevation: 4,
      ),

      // theme extensions
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/coral-bubbles.png",
          linkColor: Colors.pink[300]!,
          errorTextColor: Colors.pink[200]!,
          prefixIconColor: Colors.black.withOpacity(0.5),
          fillColor: Colors.white.withOpacity(0.3),
          borderColor: Colors.black.withOpacity(0.6),
          textColor: Colors.black.withOpacity(1),
          hintTextColor: Colors.black.withOpacity(0.7),
          authFormGradientStartColor: Colors.white.withOpacity(0.4),
          authFormGradientEndColor: Colors.white.withOpacity(0.2),
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withOpacity(1),
          appBarGradientStartColor: Colors.white.withOpacity(0.3),
          appBarGradientEndColor: Colors.white.withOpacity(0.2),
          searchBarFillColor: Colors.white.withOpacity(0.05),
        ),
        HomePageThemeExtensions(
          borderColor: Colors.white,
          backgroundGradientStartColor: Colors.white.withOpacity(0.8),
          backgroundGradientEndColor: Colors.white.withOpacity(0.6),
          previewTitleColor: Colors.black.withOpacity(1),
          previewBodyColor: Colors.black.withOpacity(1),
          dateColor: Colors.black.withOpacity(0.8),
          sigmaX: 40.0,
          sigmaY: 40.0,
          notePreviewBorderColor: Colors.white.withOpacity(0.6),
          notePreviewUnselectedGradientStartColor: Colors.transparent,
          notePreviewUnselectedGradientEndColor:
              const Color.fromARGB(255, 210, 161, 238).withOpacity(0.2),
          notePreviewSelectedGradientStartColor:
              const Color.fromARGB(255, 210, 161, 238).withOpacity(0.5),
          notePreviewSelectedGradientEndColor:
              const Color.fromARGB(255, 210, 161, 238).withOpacity(0.2),
          checkBoxSelectedColor: Colors.pinkAccent,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: const Color.fromARGB(225, 234, 94, 141),
          titleTextBoxFillColor: Colors.white.withOpacity(0.7),
          titleTextBoxBorderColor: Colors.black.withOpacity(0.8),
          titleTextBoxFocussedBorderColor: Colors.black.withOpacity(1),
          titlePlaceHolderColor: Colors.black.withOpacity(0.7),
          titleTextColor: Colors.black.withOpacity(1),
          toolbarGradientStartColor: Colors.white.withOpacity(0.75),
          toolbarGradientEndColor: Colors.white.withOpacity(0.75),
          suffixIconColor: Colors.pink,
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Colors.pink.shade300,
            iconSelectedFillColor: Colors.pink.shade300,
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.pink.shade300,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Colors.white.withOpacity(0.7),
          richTextGradientEndColor: Colors.white.withOpacity(0.5),
          mainTextColor: Colors.black,
        ),
      },
    );
  }
}
