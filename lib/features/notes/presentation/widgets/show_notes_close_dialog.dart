import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';

Future<dynamic> showCloseDialog(BuildContext context) {
  final mainTextColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

  return showCustomDialog(
    context: context,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            S.current.youHaveUnsavedChanges,
            style: TextStyle(
              fontSize: 18.0,
              color: mainTextColor,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CancelButton(
                buttonText: S.current.leave,
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              const SizedBox(width: 10),
              SubmitButton(
                isLoading: false,
                onSubmitted: () => Navigator.pop(context, false),
                buttonText: S.current.stay,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
