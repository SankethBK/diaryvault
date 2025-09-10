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

class PlainLight {
  static ThemeData getTheme(FontFamily fontFamily) {
    return ThemeData(
      textTheme: fontFamily.getGoogleFontTextTheme(),

      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        secondary: Colors.blueAccent,
        brightness: Brightness.light,
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Colors.white,
        weekdayStyle: TextStyle(color: Colors.black87),
        headerBackgroundColor: Color(0xFF1976D2),
        dayForegroundColor: MaterialStatePropertyAll(Colors.black87),
        todayForegroundColor: MaterialStatePropertyAll(Colors.white),
        yearForegroundColor: MaterialStatePropertyAll(Colors.black87),
      ),
      timePickerTheme: const TimePickerThemeData(
          backgroundColor: Color.fromARGB(255, 240, 248, 255)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue[700],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ).copyWith(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.blue[200];
              }
              return Colors.blue[700];
            },
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue[700],
          textStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue[600],
        elevation: 4,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      // used for dialogs in flutter_quill
      canvasColor: Colors.white.withOpacity(0.95),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        textStyle: const TextStyle(color: Colors.black87),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      // theme extensions
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/light-bg.webp",
          linkColor: Colors.blue[500]!,
          errorTextColor: Colors.red[600]!,
          prefixIconColor: Colors.grey[600]!,
          fillColor: Colors.grey[100]!,
          borderColor: Colors.grey[300]!,
          textColor: Colors.black87,
          hintTextColor: Colors.grey[600]!,
          authFormGradientStartColor: Colors.white.withOpacity(0.9),
          authFormGradientEndColor: Colors.white.withOpacity(0.95),
          infoTextColor: Colors.grey[700]!,
        ),
        ChipThemeExtensions(
          backgroundColor: Colors.blue[100]!,
          iconColor: Colors.blue[700]!,
          textColor: Colors.blue[800]!,
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white,
          appBarGradientStartColor: Colors.blue[600]!,
          appBarGradientEndColor: Colors.blue[600]!,
          searchBarFillColor: Colors.blue[300]!,
        ),
        HomePageThemeExtensions(
          borderColor: Colors.grey[300]!,
          backgroundGradientStartColor: Colors.white,
          backgroundGradientEndColor: Colors.grey[50]!,
          previewTitleColor: Colors.black87,
          previewBodyColor: Colors.grey[700]!,
          dateColor: Colors.grey[600]!,
          sigmaX: 2.0,
          sigmaY: 2.0,
          notePreviewBorderColor: Colors.grey[200]!,
          notePreviewUnselectedGradientStartColor: Colors.white,
          notePreviewUnselectedGradientEndColor: Colors.grey[50]!,
          notePreviewSelectedGradientStartColor: Colors.blue[50]!,
          notePreviewSelectedGradientEndColor: Colors.blue[100]!,
          checkBoxSelectedColor: Colors.blue[300]!,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: Colors.blue[700]!,
          titleTextBoxFillColor: Colors.grey[50]!,
          titleTextBoxBorderColor: Colors.grey[300]!,
          titleTextBoxFocussedBorderColor: Colors.blue[700]!,
          titlePlaceHolderColor: Colors.grey[500]!,
          titleTextColor: Colors.black87,
          suffixIconColor: Colors.grey[600]!,
          toolbarGradientStartColor: Colors.grey[50]!,
          toolbarGradientEndColor: Colors.white,
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Colors.grey[700]!,
            iconSelectedFillColor: Colors.blue[700]!,
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.grey[400]!,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Colors.white,
          richTextGradientEndColor: Colors.grey[50]!,
          mainTextColor: Colors.black87,
          quillPopupTextColor: Colors.black87,
        ),
        PopupThemeExtensions(
          barrierColor: Colors.black.withOpacity(0.3),
          popupGradientStartColor: Colors.white,
          popupGradientEndColor: Colors.grey[50]!,
          mainTextColor: Colors.black87,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: Colors.grey[300]!,
          activeColor: Colors.blue[700]!,
          syncButtonColor: Colors.blue[700]!,
          dropDownBackgroundColor: Colors.white,
        ),
      },
    );
  }
}
