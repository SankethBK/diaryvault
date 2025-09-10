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

class LushGreen {
  static ThemeData getTheme(FontFamily fontFamily) {
    return ThemeData(
      textTheme: fontFamily.getGoogleFontTextTheme(),

      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
        secondary: Colors.lightGreen,
      ),
      timePickerTheme:
          const TimePickerThemeData(backgroundColor: Color(0xFF466A5D)),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Color(0xFF59746A),
        weekdayStyle: TextStyle(color: Colors.white),
        dayForegroundColor: MaterialStatePropertyAll(Colors.white),
        todayForegroundColor: MaterialStatePropertyAll(Colors.white),
        yearForegroundColor: MaterialStatePropertyAll(Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 57, 221, 48),
          backgroundColor: const Color.fromARGB(255, 35, 151, 44),
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
            color: Color.fromARGB(255, 35, 151, 44),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 35, 151, 44),
        elevation: 4,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
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
          backgroundImage: "assets/images/lush_green.webp",
          linkColor: Colors.green[300]!,
          errorTextColor: Colors.green[200]!,
          prefixIconColor: Colors.white.withOpacity(0.5),
          fillColor: Colors.white.withOpacity(0.2),
          borderColor: Colors.white.withOpacity(0.4),
          textColor: Colors.white.withOpacity(1),
          hintTextColor: Colors.white.withOpacity(0.7),
          authFormGradientStartColor: Colors.black.withOpacity(0.5),
          authFormGradientEndColor: Colors.black.withOpacity(0.3),
          infoTextColor: Colors.white.withOpacity(0.8),
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withOpacity(1),
          appBarGradientStartColor: Colors.black.withOpacity(0.3),
          appBarGradientEndColor: Colors.black.withOpacity(0.2),
          searchBarFillColor: Colors.white.withOpacity(0.1),
        ),
        ChipThemeExtensions(
          backgroundColor: const Color(0xFF59746A),
          iconColor: Colors.green[300]!,
          textColor: Colors.white,
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
              const Color.fromARGB(255, 35, 151, 44).withOpacity(0.5),
          notePreviewSelectedGradientEndColor:
              const Color.fromARGB(255, 35, 151, 44).withOpacity(0.2),
          checkBoxSelectedColor: Colors.lightGreen,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: const Color.fromARGB(255, 57, 221, 48),
          titleTextBoxFillColor: Colors.black.withOpacity(0.6),
          titleTextBoxBorderColor: const Color.fromARGB(255, 94, 161, 58),
          titleTextBoxFocussedBorderColor:
              const Color.fromARGB(255, 57, 221, 48),
          titlePlaceHolderColor: Colors.white.withOpacity(0.7),
          titleTextColor: Colors.white.withOpacity(0.9),
          suffixIconColor: Colors.white.withOpacity(0.8),
          toolbarGradientStartColor: Colors.black.withOpacity(0.75),
          toolbarGradientEndColor: Colors.black.withOpacity(0.6),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Colors.white.withOpacity(0.8),
            iconSelectedFillColor: const Color.fromARGB(255, 35, 151, 44),
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
          activeColor: Colors.lightGreen,
          syncButtonColor: Colors.lightGreen,
          dropDownBackgroundColor: Colors.black.withOpacity(0.8),
        ),
      },
    );
  }
}
