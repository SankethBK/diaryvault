import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:flutter/material.dart';

Future<dynamic> applockWarningPopup({
  required BuildContext context,
  required String warningMessage,
}) {
  final mainTextColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

  return showCustomDialog(
    context: context,
    child: Container(
      width: 300,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            warningMessage,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: mainTextColor,
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    ),
  );
}
