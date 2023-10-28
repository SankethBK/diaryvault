import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DarkAcademia {
  static ThemeData getTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown).copyWith(
        secondary: Color(0xFF472E24),
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Color(0xFFFFE0C8),
        weekdayStyle: TextStyle(color: Color(0xFF251111)),
        headerBackgroundColor: Color(0xFF8B6B5E),
        dayForegroundColor: MaterialStatePropertyAll(Color(0xFFA89C94)),
        todayForegroundColor: MaterialStatePropertyAll(Color(0xFFFFFFFF)),
        yearForegroundColor: MaterialStatePropertyAll(Color(0xFFA89C94)),
      ),
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: Color(0xFFFFE0C8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF8B6B5E),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: Color(0xFF57393A),
            width: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFFA89C94),
          textStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF57393A),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF8B6B5E),
        elevation: 4,
      ),
      canvasColor: Color(0xFFFFE0C8),
      popupMenuTheme: PopupMenuThemeData(
        color: Color(0xFF57393A),
        textStyle: const TextStyle(color: Color(0xFFA89C94)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/da1.jpeg",
          linkColor: Color(0xFFD39E70),
          prefixIconColor: Color(0xFFA89C94),
          fillColor: Color(0xFFA89C94),
          borderColor: Color(0xFFA89C94),
          textColor: Colors.white,
          hintTextColor: Color(0xFFA89C94),
          authFormGradientStartColor: Color(0xFF57393A),
          authFormGradientEndColor: Color(0xFF57393A),
          errorTextColor: Colors.red, // Replace with your desired color
          infoTextColor: Colors.white, // Replace with your desired color
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white,
          appBarGradientStartColor: Color(0xFF2D1F16),
          appBarGradientEndColor: Color(0xFF2D1F16),
          searchBarFillColor: Color(0xFF543831),
        ),
        HomePageThemeExtensions(
          borderColor: Color(0xFF472E24),
          backgroundGradientStartColor: Color(0xBE171010),
          backgroundGradientEndColor: Color(0xBE171010),
          previewTitleColor: Colors.white,
          previewBodyColor: Colors.white,
          dateColor: Color(0xFFA89C94),
          sigmaX: 5.0,
          sigmaY: 5.0,
          notePreviewBorderColor: Color(0xFF57393A),
          notePreviewUnselectedGradientStartColor: Color(0xFF8B6B5E),
          notePreviewUnselectedGradientEndColor: Color(0xFF8B6B5E),
          notePreviewSelectedGradientStartColor: Color(0xFF472E24),
          notePreviewSelectedGradientEndColor: Color(0xFF472E24),
          checkBoxSelectedColor: Color(0xFF472E24),
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: const Color.fromARGB(255, 48, 140, 221),
          titleTextBoxFillColor: Color(0xFF2D1F16),
          titleTextBoxBorderColor: Color(0xFFA89C94),
          titleTextBoxFocussedBorderColor: Color(0xFFA89C94),
          titlePlaceHolderColor: Color(0xFFA89C94),
          titleTextColor: Colors.white,
          suffixIconColor: Color(0xFFA89C94),
          toolbarGradientStartColor: Color(0xFF2D1F16),
          toolbarGradientEndColor: Color(0xFF2D1F16),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Color(0xFFA89C94),
            iconSelectedFillColor: Color(0x5CEF8080),
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.grey.shade400,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Color(0x6F171010),
          richTextGradientEndColor: Color(0x62171010),
          mainTextColor: Colors.white,
          quillPopupTextColor: Colors.white,
        ),
        PopupThemeExtensions(
          barrierColor: Colors.white.withOpacity(0.3),
          popupGradientStartColor: Color(0xFF2D1F16),
          popupGradientEndColor: Color(0xFF2D1F16),
          mainTextColor: Colors.white,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: Color(0xFFA89C94),
          activeColor: Color(0xFFEF8080),
          syncButtonColor: Color(0xFFEF8080),
          dropDownBackgroundColor: Color(0xFF57393A),
        ),
      },
    );
  }
}
