import 'package:dairy_app/app/themes/custom_theme/custom_theme_config.dart';
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

/// Builds a full ThemeData from a user generated [CustomThemeConfig].
///
/// Colors are derived from two palette colors extracted from the user's
/// background image ([CustomThemeConfig.accentColor] and
/// [CustomThemeConfig.mutedColor]), combined with black/white overlays
/// depending on the chosen brightness.
class CustomTheme {
  static ThemeData getTheme(FontFamily fontFamily, CustomThemeConfig config) {
    final accent = config.accentColor;
    final muted = config.mutedColor;
    final isDark = config.isDark;

    // base overlay used to tint surfaces over the background image
    final overlay = isDark ? Colors.black : Colors.white;
    final opposite = isDark ? Colors.white : Colors.black;
    final mainTextColor =
        isDark ? Colors.white : const Color(0xDD000000); // black87
    final subtleTextColor = isDark
        ? Colors.white.withValues(alpha: 0.7)
        : const Color(0xFF616161); // grey[700]

    return ThemeData(
      useMaterial3: false,
      textTheme: fontFamily.getGoogleFontTextTheme(),

      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ).copyWith(
        secondary: accent,
      ),
      timePickerTheme: TimePickerThemeData(backgroundColor: muted),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: muted,
        weekdayStyle: TextStyle(color: mainTextColor),
        dayForegroundColor: MaterialStatePropertyAll(mainTextColor),
        todayForegroundColor: const MaterialStatePropertyAll(Colors.white),
        yearForegroundColor: MaterialStatePropertyAll(mainTextColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: accent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: opposite.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? Colors.white : accent,
          textStyle: TextStyle(
            fontSize: 16,
            color: accent,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const CircleBorder(),
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
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDark ? Colors.black : Colors.white,
      ),
      // used for dialogs in flutter_quill
      canvasColor: overlay.withValues(alpha: isDark ? 0.7 : 0.95),
      popupMenuTheme: PopupMenuThemeData(
        color: overlay.withValues(alpha: isDark ? 0.9 : 1.0),
        textStyle: TextStyle(color: mainTextColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      // theme extensions
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: config.backgroundImagePath,
          linkColor: accent,
          errorTextColor: isDark ? Colors.red[200]! : Colors.red[600]!,
          prefixIconColor: opposite.withValues(alpha: 0.5),
          fillColor: opposite.withValues(alpha: isDark ? 0.2 : 0.05),
          borderColor: opposite.withValues(alpha: isDark ? 0.4 : 0.2),
          textColor: mainTextColor,
          hintTextColor: opposite.withValues(alpha: 0.6),
          authFormGradientStartColor:
              overlay.withValues(alpha: isDark ? 0.5 : 0.9),
          authFormGradientEndColor:
              overlay.withValues(alpha: isDark ? 0.3 : 0.95),
          infoTextColor: opposite.withValues(alpha: 0.8),
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withValues(alpha: 1),
          appBarGradientStartColor: overlay.withValues(alpha: 0.3),
          appBarGradientEndColor: overlay.withValues(alpha: 0.2),
          searchBarFillColor: opposite.withValues(alpha: 0.1),
        ),
        ChipThemeExtensions(
          backgroundColor: muted,
          iconColor: accent,
          textColor: Colors.white,
        ),
        HomePageThemeExtensions(
          borderColor: isDark ? Colors.black : Colors.grey[300]!,
          backgroundGradientStartColor:
              overlay.withValues(alpha: isDark ? 0.8 : 1.0),
          backgroundGradientEndColor:
              overlay.withValues(alpha: isDark ? 0.6 : 0.95),
          previewTitleColor: mainTextColor,
          previewBodyColor: subtleTextColor,
          dateColor: opposite.withValues(alpha: 0.8),
          sigmaX: isDark ? 5.0 : 2.0,
          sigmaY: isDark ? 5.0 : 2.0,
          notePreviewBorderColor: opposite.withValues(alpha: 0.3),
          notePreviewUnselectedGradientStartColor:
              opposite.withValues(alpha: 0.05),
          notePreviewUnselectedGradientEndColor:
              opposite.withValues(alpha: 0.05),
          notePreviewSelectedGradientStartColor:
              accent.withValues(alpha: 0.5),
          notePreviewSelectedGradientEndColor: accent.withValues(alpha: 0.2),
          checkBoxSelectedColor: accent,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: accent,
          titleTextBoxFillColor: overlay.withValues(alpha: isDark ? 0.6 : 0.9),
          titleTextBoxBorderColor: opposite.withValues(alpha: 0.3),
          titleTextBoxFocussedBorderColor: accent,
          titlePlaceHolderColor: opposite.withValues(alpha: 0.5),
          titleTextColor: mainTextColor,
          suffixIconColor: opposite.withValues(alpha: 0.8),
          toolbarGradientStartColor:
              overlay.withValues(alpha: isDark ? 0.75 : 0.9),
          toolbarGradientEndColor:
              overlay.withValues(alpha: isDark ? 0.6 : 0.95),
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: opposite.withValues(alpha: 0.8),
            iconSelectedFillColor: accent,
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.grey.shade400,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor:
              overlay.withValues(alpha: isDark ? 0.7 : 0.9),
          richTextGradientEndColor:
              overlay.withValues(alpha: isDark ? 0.5 : 0.95),
          mainTextColor: mainTextColor,
          quillPopupTextColor: mainTextColor,
        ),
        PopupThemeExtensions(
          barrierColor: opposite.withValues(alpha: 0.3),
          popupGradientStartColor: overlay.withValues(alpha: isDark ? 0.6 : 1),
          popupGradientEndColor: overlay.withValues(alpha: isDark ? 0.4 : 0.95),
          mainTextColor: mainTextColor,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: opposite.withValues(alpha: 0.5),
          activeColor: accent,
          syncButtonColor: accent,
          dropDownBackgroundColor: overlay.withValues(alpha: isDark ? 0.8 : 1),
        ),
      },
    );
  }
}
