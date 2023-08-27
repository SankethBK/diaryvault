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
          foregroundColor: Color.fromARGB(255, 48, 140, 221),
          backgroundColor: Color.fromARGB(255, 36, 46, 178),
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
        AdditionalThemeExtensions(
          backgroundImage: "assets/images/space-image.jpeg",
          linkColor: Colors.blue[300]!,
          errorTextColor: Colors.blue[200]!,
        )
      },
    );
  }
}
