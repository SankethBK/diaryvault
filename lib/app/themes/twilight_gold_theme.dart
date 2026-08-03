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
        headerBackgroundColor: primaryPurple.withValues(alpha: 0.8),
        dayForegroundColor: const MaterialStatePropertyAll(accentGold),
        todayForegroundColor: const MaterialStatePropertyAll(Colors.white),
        yearForegroundColor: const MaterialStatePropertyAll(accentGold),
      ),
      timePickerTheme: const TimePickerThemeData(
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
            color: accentGold.withValues(alpha: 0.5),
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
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryPurple,
        foregroundColor: accentGold,
        elevation: 4,
        shape: CircleBorder(),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      chipTheme: const ChipThemeData(
        shape: StadiumBorder(),
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
        labelPadding: EdgeInsets.symmetric(horizontal: 4.0),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: Colors.white),
      ),



      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: primaryPurple,
      ),
      canvasColor: primaryPurple.withValues(alpha: 0.9),
      popupMenuTheme: PopupMenuThemeData(
        color: primaryPurple.withValues(alpha: 0.95),
        textStyle: const TextStyle(color: accentGold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: accentGold.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: primaryPurple.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: accentGold.withValues(alpha: 0.2),
            width: 0.8,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: accentGold.withValues(alpha: 0.2),
            width: 0.8,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: accentGold.withValues(alpha: 0.8),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.redAccent.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/twilight-gold.webp",
          linkColor: accentGold,
          errorTextColor: Colors.redAccent,
          prefixIconColor: accentGold.withValues(alpha: 0.7),
          fillColor: primaryPurple.withValues(alpha: 0.3),
          borderColor: accentGold.withValues(alpha: 0.3),
          textColor: accentGold,
          hintTextColor: accentGold.withValues(alpha: 0.6),
          authFormGradientStartColor: primaryPurple.withValues(alpha: 0.8),
          authFormGradientEndColor: primaryPurple.withValues(alpha: 0.6),
          infoTextColor: accentGold.withValues(alpha: 0.8),
        ),
        ChipThemeExtensions(
          backgroundColor: primaryPurple,
          iconColor: accentGold,
          textColor: accentGold,
        ),
        AppbarThemeExtensions(
          iconColor: accentGold,
          appBarGradientStartColor: primaryPurple,
          appBarGradientEndColor: primaryPurple.withValues(alpha: 0.95),
          searchBarFillColor: const Color(0xFF3D2A59),
        ),
        HomePageThemeExtensions(
          borderColor: accentGold.withValues(alpha: 0.2),
          backgroundGradientStartColor: primaryPurple,
          backgroundGradientEndColor: primaryPurple.withValues(alpha: 0.9),
          previewTitleColor: accentGold,
          previewBodyColor: accentGold.withValues(alpha: 0.9),
          dateColor: accentGold.withValues(alpha: 0.7),
          sigmaX: 5.0,
          sigmaY: 5.0,
          notePreviewBorderColor: accentGold.withValues(alpha: 0.2),
          notePreviewUnselectedGradientStartColor:
              primaryPurple.withValues(alpha: 0.4),
          notePreviewUnselectedGradientEndColor: primaryPurple.withValues(alpha: 0.2),
          notePreviewSelectedGradientStartColor: primaryPurple.withValues(alpha: 0.8),
          notePreviewSelectedGradientEndColor: primaryPurple.withValues(alpha: 0.6),
          checkBoxSelectedColor: accentGold,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: accentGold,
          titleTextBoxFillColor: primaryPurple.withValues(alpha: 0.7),
          titleTextBoxBorderColor: accentGold.withValues(alpha: 0.3),
          titleTextBoxFocussedBorderColor: accentGold.withValues(alpha: 0.6),
          titlePlaceHolderColor: accentGold.withValues(alpha: 0.6),
          titleTextColor: accentGold,
          suffixIconColor: accentGold.withValues(alpha: 0.8),
          toolbarGradientStartColor: primaryPurple.withValues(alpha: 0.95),
          toolbarGradientEndColor: primaryPurple.withValues(alpha: 0.9),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: accentGold,
            iconUnselectedColor: accentGold.withValues(alpha: 0.6),
            iconSelectedFillColor: primaryPurple.withValues(alpha: 0.8),
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: accentGold.withValues(alpha: 0.3),
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: primaryPurple.withValues(alpha: 0.95),
          richTextGradientEndColor: primaryPurple.withValues(alpha: 0.9),
          mainTextColor: accentGold,
          quillPopupTextColor: accentGold,
        ),
        PopupThemeExtensions(
          barrierColor: primaryPurple.withValues(alpha: 0.3),
          popupGradientStartColor: primaryPurple.withValues(alpha: 0.95),
          popupGradientEndColor: primaryPurple.withValues(alpha: 0.9),
          mainTextColor: accentGold,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: accentGold.withValues(alpha: 0.3),
          activeColor: accentGold,
          syncButtonColor: accentGold,
          dropDownBackgroundColor: primaryPurple.withValues(alpha: 0.95),
        ),
      },
    );
  }
}
