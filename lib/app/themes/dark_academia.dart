import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/chip_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/font/font_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class DarkAcademia {
  static ThemeData getTheme(FontFamily fontFamily) {
    return ThemeData(
      textTheme: fontFamily.getGoogleFontTextTheme(),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown).copyWith(
        secondary: const Color.fromARGB(255, 217, 168, 149),
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
          foregroundColor: const Color.fromARGB(255, 217, 168, 149),
          backgroundColor: const Color.fromARGB(215, 157, 102, 103),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: const BorderSide(
            color: Color(0xFF57393A),
            width: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
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
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      canvasColor: const Color(0xFFFFE0C8),
      popupMenuTheme: PopupMenuThemeData(
        color: const Color(0xFF57393A),
        textStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/dark-academia.webp",
          linkColor: const Color(0xFFD39E70),
          prefixIconColor: const Color.fromARGB(255, 87, 57, 58),
          fillColor: const Color(0xFFA89C94),
          borderColor: const Color(0xFFA89C94),
          textColor: Colors.white,
          hintTextColor: const Color.fromARGB(255, 87, 57, 58),
          authFormGradientStartColor: const Color.fromARGB(216, 87, 57, 58),
          authFormGradientEndColor: const Color.fromARGB(155, 87, 57, 58),
          errorTextColor: Colors.red, // Replace with your desired color
          infoTextColor: Colors.white, // Replace with your desired color
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white,
          appBarGradientStartColor: const Color(0xFF2D1F16),
          appBarGradientEndColor: const Color(0xFF2D1F16),
          searchBarFillColor: const Color(0xFF543831),
        ),
        ChipThemeExtensions(
          backgroundColor: const Color.fromARGB(216, 87, 57, 58),
          iconColor: const Color(0xFFA89C94),
          textColor: Colors.white,
        ),
        HomePageThemeExtensions(
          borderColor: const Color(0xFF472E24),
          backgroundGradientStartColor: const Color(0xBE171010),
          backgroundGradientEndColor: const Color(0xBE171010),
          previewTitleColor: Colors.white,
          previewBodyColor: Colors.white,
          dateColor: const Color(0xFFA89C94),
          sigmaX: 5.0,
          sigmaY: 5.0,
          notePreviewBorderColor: const Color(0xFF57393A),
          notePreviewUnselectedGradientStartColor:
              const Color.fromARGB(88, 139, 107, 94),
          notePreviewUnselectedGradientEndColor:
              const Color.fromARGB(50, 139, 107, 94),
          notePreviewSelectedGradientStartColor: const Color(0xFF472E24),
          notePreviewSelectedGradientEndColor: const Color(0xFF472E24),
          checkBoxSelectedColor: const Color(0xFF472E24),
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: const Color.fromARGB(255, 48, 140, 221),
          titleTextBoxFillColor: const Color.fromARGB(180, 23, 16, 16),
          titleTextBoxBorderColor: const Color(0xFFA89C94),
          titleTextBoxFocussedBorderColor: const Color(0xFFA89C94),
          titlePlaceHolderColor: const Color(0xFFA89C94),
          titleTextColor: Colors.white,
          suffixIconColor: const Color(0xFFA89C94),
          toolbarGradientStartColor: const Color.fromARGB(230, 23, 16, 16),
          toolbarGradientEndColor: const Color.fromARGB(220, 23, 16, 16),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: const Color(0xFFA89C94),
            iconSelectedFillColor: const Color(0x5CEF8080),
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.grey.shade400,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: const Color.fromARGB(220, 23, 16, 16),
          richTextGradientEndColor: const Color.fromARGB(170, 23, 16, 16),
          mainTextColor: Colors.white,
          quillPopupTextColor: Colors.white,
        ),
        PopupThemeExtensions(
          barrierColor: Colors.white.withOpacity(0.3),
          popupGradientStartColor: const Color.fromARGB(222, 45, 31, 22),
          popupGradientEndColor: const Color.fromARGB(200, 45, 31, 22),
          mainTextColor: Colors.white,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: const Color(0xFFA89C94),
          activeColor: const Color(0xFFEF8080),
          syncButtonColor: const Color(0xFFEF8080),
          dropDownBackgroundColor: const Color(0xFF57393A),
        ),
      },
    );
  }
}
