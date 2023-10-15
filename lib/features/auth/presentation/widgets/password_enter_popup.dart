import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<dynamic> passwordLoginPopup(
    {required BuildContext context, required Function submitPassword}) {
  String password = "";

  void assignPassword(String val) {
    password = val;
  }

  bool isLoading = false;

  final mainTextColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

  return showCustomDialog(
    context: context,
    child: Container(
      width: 300,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context).enterCurrentPassword,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: mainTextColor,
              )),
          const SizedBox(height: 25),
          AuthPasswordInput(
            getPasswordErrors: () => null,
            onPasswordChanged: assignPassword,
            autoFocus: true,
          ),
          const SizedBox(height: 25),
          StatefulBuilder(builder: (context, setState) {
            return SubmitButton(
              isLoading: isLoading,
              onSubmitted: () async {
                setState(() {
                  isLoading = true;
                });
                bool result = await submitPassword(password);
                if (result == false) {
                  setState(() {
                    isLoading = false;
                  });
                  showToast(AppLocalizations.of(context).incorrectPassword);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  showToast(AppLocalizations.of(context).passwordVerified);
                  await Future.delayed(const Duration(milliseconds: 300));
                  Navigator.of(context).pop(password);
                }
              },
              buttonText: AppLocalizations.of(context).submit,
            );
          })
        ],
      ),
    ),
  );
}
