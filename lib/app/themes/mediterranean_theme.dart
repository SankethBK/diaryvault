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

class Mediterranean {
  static ThemeData getTheme(FontFamily fontFamily) {
    return ThemeData(
      textTheme: fontFamily.getGoogleFontTextTheme(),

      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(
        secondary: Colors.orangeAccent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.indigo[800],
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
          foregroundColor: Colors.indigo,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.indigo,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.orangeAccent,
        elevation: 4,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      canvasColor: Colors.white.withOpacity(0.9),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white.withOpacity(0.9),
        textStyle: const TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/mediterranean.webp",
          linkColor: Colors.orange[400]!,
          errorTextColor: Colors.orange[200]!,
          prefixIconColor: Colors.black.withOpacity(0.5),
          fillColor: Colors.white.withOpacity(0.3),
          borderColor: Colors.black.withOpacity(0.6),
          textColor: Colors.black.withOpacity(1),
          hintTextColor: Colors.black.withOpacity(0.7),
          authFormGradientStartColor: Colors.white.withOpacity(0.4),
          authFormGradientEndColor: Colors.white.withOpacity(0.2),
          infoTextColor: Colors.white.withOpacity(0.7),
        ),
        ChipThemeExtensions(
          backgroundColor: const Color(0xFFF2C2B0),
          iconColor: Colors.orange[400]!,
          textColor: const Color(0xFF363434),
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withOpacity(1),
          appBarGradientStartColor: Colors.indigo[900]!,
          appBarGradientEndColor: Colors.indigo[700]!,
          searchBarFillColor: Colors.white.withOpacity(0.1),
        ),
        HomePageThemeExtensions(
          borderColor: Colors.white,
          backgroundGradientStartColor: Colors.indigo[800]!.withOpacity(0.6),
          backgroundGradientEndColor: Colors.orangeAccent.withOpacity(0.3),
          previewTitleColor: Colors.black87,
          previewBodyColor: Colors.black87,
          dateColor: Colors.black54,
          sigmaX: 5.0,
          sigmaY: 5.0,
          notePreviewBorderColor: Colors.white.withOpacity(0.4),
          notePreviewUnselectedGradientStartColor: Colors.transparent,
          notePreviewUnselectedGradientEndColor:
          const Color.fromARGB(255, 210, 161, 238).withOpacity(0.2),
          notePreviewSelectedGradientStartColor:
          Colors.orangeAccent.withOpacity(0.5),
          notePreviewSelectedGradientEndColor:
          Colors.indigo[700]!.withOpacity(0.2),
          checkBoxSelectedColor: Colors.orangeAccent,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: const Color.fromARGB(225, 234, 94, 141),
          titleTextBoxFillColor: Colors.white.withOpacity(0.6),
          titleTextBoxBorderColor: Colors.indigo[700]!.withOpacity(0.7),
          titleTextBoxFocussedBorderColor: Colors.orangeAccent,
          titlePlaceHolderColor: Colors.black54,
          titleTextColor: Colors.black87,
          toolbarGradientStartColor: Colors.white.withOpacity(0.5),
          toolbarGradientEndColor: Colors.white.withOpacity(0.5),
          suffixIconColor: Colors.indigo[800]!,
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Colors.orange[400]!,
            iconSelectedFillColor: Colors.orange[400]!,
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.orange[400]!,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Colors.white.withOpacity(0.7),
          richTextGradientEndColor: Colors.white.withOpacity(0.5),
          mainTextColor: Colors.black,
          quillPopupTextColor: Colors.indigo[800]!,
        ),
        PopupThemeExtensions(
          barrierColor: Colors.black.withOpacity(0.5),
          popupGradientStartColor: Colors.white.withOpacity(0.8),
          popupGradientEndColor: Colors.white.withOpacity(0.6),
          mainTextColor: Colors.black,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: Colors.black38,
          activeColor: Colors.orangeAccent,
          syncButtonColor: Colors.orangeAccent,
          dropDownBackgroundColor: Colors.white.withOpacity(0.8),
        ),
      },
    );
  }
}
