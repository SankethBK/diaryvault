import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class Cosmic {
  static ThemeData getTheme() {
    return ThemeData(
      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        secondary: Colors.blueAccent,
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Color(0xFF4B6996),
        weekdayStyle: TextStyle(color: Colors.white),
        headerBackgroundColor: Color(0xFF4471EC),
        dayForegroundColor: MaterialStatePropertyAll(Colors.white),
        todayForegroundColor: MaterialStatePropertyAll(Colors.white),
        yearForegroundColor: MaterialStatePropertyAll(Colors.white),
      ),
      timePickerTheme:
          const TimePickerThemeData(backgroundColor: Color(0xFF49638B)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 48, 140, 221),
          backgroundColor: const Color(0xFF242EB2),
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
          foregroundColor: Colors.white,
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
      // used for dialogs in flutter_quill
      canvasColor: Colors.black.withOpacity(0.7),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.black.withOpacity(0.9), // Set the background color
        textStyle: const TextStyle(color: Colors.white), // Set text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
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
          infoTextColor: Colors.white.withOpacity(0.7),
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
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: const Color.fromARGB(255, 48, 140, 221),
          titleTextBoxFillColor: Colors.black.withOpacity(0.4),
          titleTextBoxBorderColor: Colors.white.withOpacity(0.5),
          titleTextBoxFocussedBorderColor: Colors.white.withOpacity(0.8),
          titlePlaceHolderColor: Colors.white.withOpacity(0.7),
          titleTextColor: Colors.white.withOpacity(0.9),
          suffixIconColor: Colors.white.withOpacity(0.8),
          toolbarGradientStartColor: Colors.black.withOpacity(0.75),
          toolbarGradientEndColor: Colors.black.withOpacity(0.6),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Colors.white.withOpacity(0.8),
            iconSelectedFillColor: const Color.fromARGB(255, 36, 46, 178),
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.grey.shade400,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Colors.black.withOpacity(0.7),
          richTextGradientEndColor: Colors.black.withOpacity(0.5),
          mainTextColor: Colors.white,
          quillPopupTextColor: Colors.white,
        ),
        PopupThemeExtensions(
          barrierColor: Colors.white.withOpacity(0.3),
          popupGradientStartColor: Colors.black.withOpacity(0.6),
          popupGradientEndColor: Colors.black.withOpacity(0.4),
          mainTextColor: Colors.white,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: Colors.white.withOpacity(0.5),
          activeColor: Colors.blueAccent,
          syncButtonColor: Colors.blueAccent,
          dropDownBackgroundColor: Colors.black.withOpacity(0.8),
        ),
      },
    );
  }
}
