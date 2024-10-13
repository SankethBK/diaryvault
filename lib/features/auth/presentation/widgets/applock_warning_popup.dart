import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';

Future<dynamic> applockWarningPopup({
  required BuildContext context,
  required String warningMessage,
}) {
  final mainTextColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

  var checkboxAccepted = false;

  return showCustomDialog(
    context: context,
    child: Container(
      width: 300,
      padding: const EdgeInsets.all(20.0),
      child: StatefulBuilder(builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.warning,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: mainTextColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              warningMessage,
              style: TextStyle(
                color: mainTextColor,
              ),
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(S.current.acceptRisk),
              value: checkboxAccepted,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  checkboxAccepted = value!;
                });
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CancelButton(
                  buttonText: S.current.cancel,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                const SizedBox(width: 20),
                SubmitButton(
                  isLoading: false,
                  onSubmitted: () => Navigator.of(context).pop(true),
                  buttonText: S.current.done,
                  isDisabled: !checkboxAccepted,
                ),
              ],
            )
          ],
        );
      }),
    ),
  );
}
