import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/chip_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/font/font_cubit.dart';

class TwilightGold {
  static ThemeData getTheme(FontFamily fontFamily) {
    // Primary colors
    const primaryPurple = Color(0xFF2A1B3D);
    const accentGold = Color(0xFFE6B450);

    return ThemeData(
      textTheme: fontFamily.getGoogleFontTextTheme(),
      colorScheme:
          ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
        secondary: accentGold,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: primaryPurple,
        weekdayStyle: const TextStyle(color: accentGold),
        headerBackgroundColor: primaryPurple.withOpacity(0.8),
        dayForegroundColor: const MaterialStatePropertyAll(accentGold),
        todayForegroundColor: const MaterialStatePropertyAll(Colors.white),
        yearForegroundColor: const MaterialStatePropertyAll(accentGold),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: primaryPurple,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: accentGold,
          backgroundColor: primaryPurple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: accentGold.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentGold,
          textStyle: const TextStyle(
            fontSize: 16,
            color: accentGold,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryPurple,
        foregroundColor: accentGold,
        elevation: 4,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: primaryPurple,
      ),
      canvasColor: primaryPurple.withOpacity(0.9),
      popupMenuTheme: PopupMenuThemeData(
        color: primaryPurple.withOpacity(0.95),
        textStyle: const TextStyle(color: accentGold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage:
              "assets/images/twilight-gold.webp",
          linkColor: accentGold,
          errorTextColor: Colors.redAccent,
          prefixIconColor: accentGold.withOpacity(0.7),
          fillColor: primaryPurple.withOpacity(0.3),
          borderColor: accentGold.withOpacity(0.3),
          textColor: accentGold,
          hintTextColor: accentGold.withOpacity(0.6),
          authFormGradientStartColor: primaryPurple.withOpacity(0.8),
          authFormGradientEndColor: primaryPurple.withOpacity(0.6),
          infoTextColor: accentGold.withOpacity(0.8),
        ),
        ChipThemeExtensions(
          backgroundColor: primaryPurple,
          iconColor: accentGold,
          textColor: accentGold,
        ),
        AppbarThemeExtensions(
          iconColor: accentGold,
          appBarGradientStartColor: primaryPurple,
          appBarGradientEndColor: primaryPurple.withOpacity(0.95),
          searchBarFillColor: Color(0xFF3D2A59),
        ),
        HomePageThemeExtensions(
          borderColor: accentGold.withOpacity(0.2),
          backgroundGradientStartColor: primaryPurple,
          backgroundGradientEndColor: primaryPurple.withOpacity(0.9),
          previewTitleColor: accentGold,
          previewBodyColor: accentGold.withOpacity(0.9),
          dateColor: accentGold.withOpacity(0.7),
          sigmaX: 5.0,
          sigmaY: 5.0,
          notePreviewBorderColor: accentGold.withOpacity(0.2),
          notePreviewUnselectedGradientStartColor:
              primaryPurple.withOpacity(0.4),
          notePreviewUnselectedGradientEndColor: primaryPurple.withOpacity(0.2),
          notePreviewSelectedGradientStartColor: primaryPurple.withOpacity(0.8),
          notePreviewSelectedGradientEndColor: primaryPurple.withOpacity(0.6),
          checkBoxSelectedColor: accentGold,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: accentGold,
          titleTextBoxFillColor: primaryPurple.withOpacity(0.7),
          titleTextBoxBorderColor: accentGold.withOpacity(0.3),
          titleTextBoxFocussedBorderColor: accentGold.withOpacity(0.6),
          titlePlaceHolderColor: accentGold.withOpacity(0.6),
          titleTextColor: accentGold,
          suffixIconColor: accentGold.withOpacity(0.8),
          toolbarGradientStartColor: primaryPurple.withOpacity(0.95),
          toolbarGradientEndColor: primaryPurple.withOpacity(0.9),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: accentGold,
            iconUnselectedColor: accentGold.withOpacity(0.6),
            iconSelectedFillColor: primaryPurple.withOpacity(0.8),
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: accentGold.withOpacity(0.3),
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: primaryPurple.withOpacity(0.95),
          richTextGradientEndColor: primaryPurple.withOpacity(0.9),
          mainTextColor: accentGold,
          quillPopupTextColor: accentGold,
        ),
        PopupThemeExtensions(
          barrierColor: primaryPurple.withOpacity(0.3),
          popupGradientStartColor: primaryPurple.withOpacity(0.95),
          popupGradientEndColor: primaryPurple.withOpacity(0.9),
          mainTextColor: accentGold,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: accentGold.withOpacity(0.3),
          activeColor: accentGold,
          syncButtonColor: accentGold,
          dropDownBackgroundColor: primaryPurple.withOpacity(0.95),
        ),
      },
    );
  }
}
