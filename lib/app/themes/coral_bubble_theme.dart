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

class CoralBubble {
  static ThemeData getTheme(FontFamily fontFamily) {
    return ThemeData(
      textTheme: fontFamily.getGoogleFontTextTheme(),

      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
        secondary: Colors.pinkAccent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.pink[300],
          backgroundColor: Colors.purple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: Colors.black.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.purple,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.purple,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.pinkAccent,
        elevation: 4,
        shape: CircleBorder(),
        foregroundColor: Colors.white,
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
        backgroundColor: Colors.white,
      ),
      // used for dialogs in flutter_quill
      canvasColor: Colors.white.withValues(alpha: 0.9),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white.withValues(alpha: 0.9), // Set the background color
        textStyle: const TextStyle(color: Colors.black), // Set text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      // theme extensions
      extensions: <ThemeExtension<dynamic>>{
        AuthPageThemeExtensions(
          backgroundImage: "assets/images/coral-bubbles.webp",
          linkColor: Colors.pink[300]!,
          errorTextColor: Colors.pink[200]!,
          prefixIconColor: Colors.black.withValues(alpha: 0.5),
          fillColor: Colors.white.withValues(alpha: 0.3),
          borderColor: Colors.black.withValues(alpha: 0.6),
          textColor: Colors.black.withValues(alpha: 1),
          hintTextColor: Colors.black.withValues(alpha: 0.7),
          authFormGradientStartColor: Colors.white.withValues(alpha: 0.4),
          authFormGradientEndColor: Colors.white.withValues(alpha: 0.2),
          infoTextColor: Colors.white.withValues(alpha: 0.8),
        ),
        ChipThemeExtensions(
          backgroundColor: const Color.fromARGB(255, 219, 127, 158),
          iconColor: Colors.pink[200]!,
          textColor: const Color.fromARGB(255, 54, 52, 52),
        ),
        AppbarThemeExtensions(
          iconColor: Colors.white.withValues(alpha: 1),
          appBarGradientStartColor: Colors.white.withValues(alpha: 0.3),
          appBarGradientEndColor: Colors.white.withValues(alpha: 0.2),
          searchBarFillColor: Colors.white.withValues(alpha: 0.05),
        ),
        HomePageThemeExtensions(
          borderColor: Colors.white,
          backgroundGradientStartColor: Colors.white.withValues(alpha: 0.8),
          backgroundGradientEndColor: Colors.white.withValues(alpha: 0.6),
          previewTitleColor: Colors.black.withValues(alpha: 1),
          previewBodyColor: Colors.black.withValues(alpha: 1),
          dateColor: Colors.black.withValues(alpha: 0.8),
          sigmaX: 40.0,
          sigmaY: 40.0,
          notePreviewBorderColor: Colors.white.withValues(alpha: 0.6),
          notePreviewUnselectedGradientStartColor: Colors.transparent,
          notePreviewUnselectedGradientEndColor:
              const Color.fromARGB(255, 210, 161, 238).withValues(alpha: 0.2),
          notePreviewSelectedGradientStartColor:
              const Color.fromARGB(255, 210, 161, 238).withValues(alpha: 0.5),
          notePreviewSelectedGradientEndColor:
              const Color.fromARGB(255, 210, 161, 238).withValues(alpha: 0.2),
          checkBoxSelectedColor: Colors.pinkAccent,
        ),
        NoteCreatePageThemeExtensions(
          fallbackColor: const Color.fromARGB(225, 234, 94, 141),
          titleTextBoxFillColor: Colors.white.withValues(alpha: 0.7),
          titleTextBoxBorderColor: Colors.black.withValues(alpha: 0.8),
          titleTextBoxFocussedBorderColor: Colors.black.withValues(alpha: 1),
          titlePlaceHolderColor: Colors.black.withValues(alpha: 0.7),
          titleTextColor: Colors.black.withValues(alpha: 1),
          toolbarGradientStartColor: Colors.white.withValues(alpha: 0.75),
          toolbarGradientEndColor: Colors.white.withValues(alpha: 0.75),
          suffixIconColor: Colors.pink,
          toolbarTheme: QuillIconTheme(
            iconSelectedColor: Colors.white,
            iconUnselectedColor: Colors.pink.shade300,
            iconSelectedFillColor: Colors.pink.shade300,
            iconUnselectedFillColor: Colors.transparent,
            disabledIconColor: Colors.pink.shade300,
            borderRadius: 5.0,
          ),
          richTextGradientStartColor: Colors.white.withValues(alpha: 0.7),
          richTextGradientEndColor: Colors.white.withValues(alpha: 0.5),
          mainTextColor: Colors.black,
          quillPopupTextColor: Colors.purple,
        ),
        PopupThemeExtensions(
          barrierColor: Colors.black.withValues(alpha: 0.5),
          popupGradientStartColor: Colors.white.withValues(alpha: 0.8),
          popupGradientEndColor: Colors.white.withValues(alpha: 0.6),
          mainTextColor: Colors.black,
        ),
        SettingsPageThemeExtensions(
          inactiveTrackColor: Colors.black.withValues(alpha: 0.5),
          activeColor: Colors.pinkAccent,
          syncButtonColor: Colors.pinkAccent,
          dropDownBackgroundColor: Colors.white.withValues(alpha: 0.8),
        ),
      },
    );
  }
}
