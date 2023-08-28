import 'package:dairy_app/app/themes/theme_models.dart';
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
        )
      },
    );
  }
}
