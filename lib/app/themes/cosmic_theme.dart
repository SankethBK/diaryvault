import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:flutter/material.dart';

class Cosmic {
  static ThemeData getTheme() {
    return ThemeData(
      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        secondary: Colors.blueAccent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 48, 140, 221),
          backgroundColor: const Color.fromARGB(255, 36, 46, 178),
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
          foregroundColor: const Color.fromARGB(255, 36, 46, 178),
          textStyle: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 36, 46, 178),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 36, 46, 178),
        elevation: 4,
      ),

      // theme extensions
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/space-image.jpeg",
          linkColor: Colors.blue[300]!,
          errorTextColor: Colors.blue[200]!,
          prefixIconColor: Colors.white.withOpacity(0.5),
          fillColor: Colors.white.withOpacity(0.2),
          borderColor: Colors.white.withOpacity(0.4),
          textColor: Colors.white.withOpacity(1),
          hintTextColor: Colors.white.withOpacity(0.7),
          authFormGradientStartColor: Colors.black.withOpacity(0.5),
          authFormGradientEndColor: Colors.black.withOpacity(0.3),
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withOpacity(1),
          appBarGradientStartColor: Colors.black.withOpacity(0.3),
          appBarGradientEndColor: Colors.black.withOpacity(0.2),
          searchBarFillColor: Colors.white.withOpacity(0.1),
        ),
        HomePageThemeExtensions(
          borderColor: Colors.black,
          backgroundGradientStartColor: Colors.black.withOpacity(0.8),
          backgroundGradientEndColor: Colors.black.withOpacity(0.6),
          previewTitleColor: Colors.white.withOpacity(1),
          previewBodyColor: Colors.white.withOpacity(1),
          dateColor: Colors.white.withOpacity(0.8),
          sigmaX: 5.0,
          sigmaY: 5.0,
          notePreviewBorderColor: Colors.black.withOpacity(0.6),
          notePreviewUnselectedGradientStartColor:
              Colors.white.withOpacity(0.05),
          notePreviewUnselectedGradientEndColor: Colors.white.withOpacity(0.05),
          notePreviewSelectedGradientStartColor:
              const Color.fromARGB(255, 36, 46, 178).withOpacity(0.5),
          notePreviewSelectedGradientEndColor:
              const Color.fromARGB(255, 36, 46, 178).withOpacity(0.2),
          checkBoxSelectedColor: Colors.blueAccent,
        )
      },
    );
  }
}
