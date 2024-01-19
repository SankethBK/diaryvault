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

class MonochromePink {
  static ThemeData getTheme(FontFamily fontFamily) {
    return ThemeData(
      textTheme: fontFamily.getGoogleFontTextTheme(),

      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
        secondary: Color(0xffd63484),
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Color(0xFFff9bd2),
        weekdayStyle: TextStyle(color: Colors.white),
        headerBackgroundColor: Color(0xFFd63484),
        dayForegroundColor: MaterialStatePropertyAll(Color(0xff402b3a)),
        todayForegroundColor: MaterialStatePropertyAll(Color(0xffffffff)),
        yearForegroundColor: MaterialStatePropertyAll(Color(0xff402b3a)),
      ),
      timePickerTheme:
          const TimePickerThemeData(backgroundColor: Color(0xFFff9bd2)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFFff9bd2),
          backgroundColor: const Color(0xFFd63484),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: Colors.pink.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      //
      // #### TO-DO
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 16,
            color: Colors.pink[700],
          ),
        ),
      ),

//
// ############## Change color to Color.fromARGB and add const value
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFd63484),
        // Color.fromARGB(213, 255, 0, 191),
        elevation: 4,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      // used for dialogs in flutter_quill
      canvasColor: Colors.pink.withOpacity(0.3),
      popupMenuTheme: PopupMenuThemeData(
        color: const Color(0xFFd63484), // Set the background color
        textStyle: const TextStyle(color: Colors.white), // Set text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      // theme extensions
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/monochrome.png",
          linkColor: Colors.pink[300]!,
          errorTextColor: Colors.pink[200]!,
          prefixIconColor: Colors.white.withOpacity(0.7),
          fillColor: Color(0xFFff9bd2).withOpacity(0.2),
          borderColor: Color(0xFFff9bd2).withOpacity(0.4),
          textColor: Colors.white.withOpacity(1),
          hintTextColor: Colors.white.withOpacity(0.7),
          authFormGradientStartColor: Colors.pink.withOpacity(0.5),
          authFormGradientEndColor: Colors.black.withOpacity(0.3),
          infoTextColor: Colors.white.withOpacity(0.7),
        ),
        ChipThemeExtensions(
          backgroundColor: const Color(0xFFff9bd2),
          iconColor: Colors.pinkAccent,
          textColor: Colors.white,
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withOpacity(1),
          appBarGradientStartColor: const Color(0xFFd63484),
          appBarGradientEndColor: const Color(0xFFd63484),
          searchBarFillColor: Colors.white.withOpacity(0.1),
        ),
        HomePageThemeExtensions(
          borderColor: Colors.black.withOpacity(0.1),
          backgroundGradientStartColor: Colors.black.withOpacity(0.5),
          backgroundGradientEndColor: Colors.black.withOpacity(0.2),
          previewTitleColor: Colors.white.withOpacity(1),
          previewBodyColor: Colors.white.withOpacity(1),
          dateColor: Colors.white.withOpacity(0.8),
          sigmaX: 5.0,
          sigmaY: 5.0,
          notePreviewBorderColor: Colors.black.withOpacity(0.6),
          notePreviewUnselectedGradientStartColor:
              Colors.white.withOpacity(0.05),
          notePreviewUnselectedGradientEndColor: Colors.white.withOpacity(0.05),
          notePreviewSelectedGradientStartColor: Colors.black.withOpacity(0.5),
          notePreviewSelectedGradientEndColor: Colors.black.withOpacity(0.2),
          checkBoxSelectedColor: Colors.pinkAccent,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: const Color.fromARGB(255, 48, 140, 221),
          titleTextBoxFillColor: Color(0xFFff9bd2).withOpacity(0.2),
          titleTextBoxBorderColor: Color(0xFFff9bd2).withOpacity(0.4),
          titleTextBoxFocussedBorderColor: Colors.white.withOpacity(0.3),
          titlePlaceHolderColor: Colors.white.withOpacity(0.7),
          titleTextColor: Colors.white.withOpacity(0.9),
          suffixIconColor: Colors.white.withOpacity(0.8),
          toolbarGradientStartColor: Color(0xFFff9bd2).withOpacity(0.5),
          toolbarGradientEndColor: Color(0xFFff9bd2).withOpacity(0.5),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Colors.white.withOpacity(0.8),
            iconSelectedFillColor: Color(0xFFff9bd2),
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.grey.shade400,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Color(0xFFff9bd2).withOpacity(0.5),
          richTextGradientEndColor: Color(0xFFff9bd2).withOpacity(0.3),
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
          activeColor: Colors.pink,
          syncButtonColor: Colors.pink,
          dropDownBackgroundColor: Colors.black.withOpacity(0.8),
        ),
      },
    );
  }
}
