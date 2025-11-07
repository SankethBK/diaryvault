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

// COLOR : Associated component(s)
// #5D8AA8 (Sakura Blue) - Primary buttons, app bar, borders
// #B3001B (Torii Red) - FAB, accents, links, selected states
// #7BA05B (Bamboo Green) - App bar gradient, background accents
// #E6D7B8 (Sand Beige) - Chips, note previews
// Light Text Colors - Home page text, preview content

class Fuji {
  static ThemeData getTheme(FontFamily fontFamily) {
    return ThemeData(
      textTheme: fontFamily.getGoogleFontTextTheme(),

      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        secondary: Color(0xFFB3001B),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF5D8AA8),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFF5D8AA8),
          textStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF5D8AA8),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFB3001B),
        elevation: 4,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      canvasColor: Colors.white.withOpacity(0.95),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white.withOpacity(0.95),
        textStyle: const TextStyle(color: Colors.black87),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/fuji.webp",
          linkColor: Color(0xFFB3001B),
          errorTextColor: Color(0xFFFF6B6B),
          prefixIconColor: Colors.black.withOpacity(0.5),
          fillColor: Colors.white.withOpacity(0.4),
          borderColor: Colors.black.withOpacity(0.3),
          textColor: Colors.black.withOpacity(0.9),
          hintTextColor: Colors.black.withOpacity(0.6),
          authFormGradientStartColor: Colors.white.withOpacity(0.6),
          authFormGradientEndColor: Colors.white.withOpacity(0.3),
          infoTextColor: Colors.black.withOpacity(0.7),
        ),
        ChipThemeExtensions(
          backgroundColor: Color(0xFFE6D7B8),
          iconColor: Color(0xFFB3001B),
          textColor: Color(0xFF363434),
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withOpacity(1),
          appBarGradientStartColor: Color(0xFF7BA05B),
          appBarGradientEndColor: Color(0xFF5D8AA8),
          searchBarFillColor: Colors.white.withOpacity(0.2),
        ),
        HomePageThemeExtensions(
          borderColor: Colors.white,
          backgroundGradientStartColor: Color(0xFF5D8AA8).withOpacity(0.3),
          backgroundGradientEndColor: Color(0xFF7BA05B).withOpacity(0.2),
          previewTitleColor: Colors.white,
          previewBodyColor: Colors.white.withOpacity(0.9),
          dateColor: Color(0xFFB3001B),
          sigmaX: 3.0,
          sigmaY: 3.0,
          notePreviewBorderColor: Colors.white.withOpacity(0.5),
          notePreviewUnselectedGradientStartColor: Colors.transparent,
          notePreviewUnselectedGradientEndColor: Color(0xFFE6D7B8).withOpacity(0.2),
          notePreviewSelectedGradientStartColor: Color(0xFFB3001B).withOpacity(0.3),
          notePreviewSelectedGradientEndColor: Color(0xFF5D8AA8).withOpacity(0.2),
          checkBoxSelectedColor: Color(0xFFB3001B),
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: Color(0xFF5D8AA8),
          titleTextBoxFillColor: Colors.white.withOpacity(0.7),
          titleTextBoxBorderColor: Color(0xFF5D8AA8).withOpacity(0.4),
          titleTextBoxFocussedBorderColor: Color(0xFFB3001B),
          titlePlaceHolderColor: Colors.black54,
          titleTextColor: Colors.black87,
          toolbarGradientStartColor: Colors.white.withOpacity(0.8),
          toolbarGradientEndColor: Colors.white.withOpacity(0.6),
          suffixIconColor: Color(0xFF5D8AA8),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Color(0xFFB3001B),
            iconSelectedFillColor: Color(0xFFB3001B),
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Color(0xFFB3001B).withOpacity(0.5),
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Colors.white.withOpacity(0.8),
          richTextGradientEndColor: Colors.white.withOpacity(0.6),
          mainTextColor: Colors.black,
          quillPopupTextColor: Color(0xFF5D8AA8),
        ),
        PopupThemeExtensions(
          barrierColor: Colors.black.withOpacity(0.4),
          popupGradientStartColor: Colors.white.withOpacity(0.9),
          popupGradientEndColor: Colors.white.withOpacity(0.7),
          mainTextColor: Colors.black87,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: Colors.grey.shade400,
          activeColor: Color(0xFFB3001B),
          syncButtonColor: Color(0xFFB3001B),
          dropDownBackgroundColor: Colors.white.withOpacity(0.9),
        ),
      ],
    );
  }
}