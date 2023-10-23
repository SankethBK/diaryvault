import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class PlainDark {
  static ThemeData getTheme() {
    return ThemeData(
      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(
        secondary: Colors.tealAccent,
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Colors.black,
        weekdayStyle: TextStyle(color: Colors.white),
        headerBackgroundColor: Colors.teal,
        dayForegroundColor: MaterialStatePropertyAll(Colors.white),
        todayForegroundColor: MaterialStatePropertyAll(Colors.white),
        yearForegroundColor: MaterialStatePropertyAll(Colors.white),
      ),
      timePickerTheme: const TimePickerThemeData(
          backgroundColor: Color.fromARGB(255, 44, 84, 81)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // foregroundColor: const Color.fromARGB(255, 125, 199, 192),
          // backgroundColor: const Color.fromARGB(255, 80, 126, 122),
          foregroundColor: Colors.tealAccent,
          backgroundColor: Colors.teal,
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
            color: Colors.teal,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      // used for dialogs in flutter_quill
      canvasColor: Colors.black.withOpacity(0.7),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.black.withOpacity(0.8), // Set the background color
        textStyle: const TextStyle(color: Colors.white), // Set text color
      ),
      // theme extensions
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/blackbg.png",
          linkColor: const Color.fromARGB(255, 125, 199, 192),
          errorTextColor: Colors.blue[200]!,
          prefixIconColor: Colors.white.withOpacity(0.5),
          fillColor: Colors.white.withOpacity(0.2),
          borderColor: Colors.white.withOpacity(0.4),
          textColor: Colors.white.withOpacity(1),
          hintTextColor: Colors.white.withOpacity(0.7),
          authFormGradientStartColor: Colors.black.withOpacity(0.5),
          authFormGradientEndColor: Colors.black.withOpacity(0.5),
          infoTextColor: Colors.white.withOpacity(1),
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withOpacity(1),
          appBarGradientStartColor: Colors.black.withOpacity(1),
          appBarGradientEndColor: Colors.black.withOpacity(1),
          searchBarFillColor: Colors.white.withOpacity(0.1),
        ),
        HomePageThemeExtensions(
          borderColor: Colors.black,
          backgroundGradientStartColor: Colors.black.withOpacity(1),
          backgroundGradientEndColor: Colors.black.withOpacity(1),
          previewTitleColor: Colors.white.withOpacity(1),
          previewBodyColor: Colors.white.withOpacity(1),
          dateColor: Colors.white.withOpacity(0.9),
          sigmaX: 5.0,
          sigmaY: 5.0,
          notePreviewBorderColor: Colors.black.withOpacity(0.6),
          notePreviewUnselectedGradientStartColor:
              Colors.white.withOpacity(0.02),
          notePreviewUnselectedGradientEndColor: Colors.white.withOpacity(0.05),
          notePreviewSelectedGradientStartColor: Colors.teal.withOpacity(0.5),
          notePreviewSelectedGradientEndColor: Colors.teal.withOpacity(0.5),
          checkBoxSelectedColor: Colors.tealAccent.withOpacity(0.5),
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: Colors.teal,
          titleTextBoxFillColor: Colors.black.withOpacity(0.8),
          titleTextBoxBorderColor: Colors.white.withOpacity(0.3),
          titleTextBoxFocussedBorderColor: Colors.white.withOpacity(0.8),
          titlePlaceHolderColor: Colors.white.withOpacity(0.7),
          titleTextColor: Colors.white.withOpacity(0.9),
          suffixIconColor: Colors.white.withOpacity(0.8),
          toolbarGradientStartColor: Colors.black.withOpacity(0.8),
          toolbarGradientEndColor: Colors.black.withOpacity(0.8),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Colors.white.withOpacity(0.8),
            iconSelectedFillColor: Colors.teal,
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.grey.shade400,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Colors.black.withOpacity(0.8),
          richTextGradientEndColor: Colors.black.withOpacity(0.8),
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
          activeColor: Colors.tealAccent,
          syncButtonColor: Colors.teal,
          dropDownBackgroundColor: Colors.black.withOpacity(0.8),
        ),
      },
    );
  }
}
