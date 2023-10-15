import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'password_input_field.dart';

Future<dynamic> passwordResetPopup(
    {required BuildContext context, required Function submitPassword}) {
  String newPassword = "";
  String confirmNewPassword = "";

  void assignNewPassword(String val) {
    newPassword = val;
  }

  void assignConfirmNewPassword(String val) {
    confirmNewPassword = val;
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
          Text(AppLocalizations.of(context).resetPassword,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: mainTextColor)),
          const SizedBox(height: 25),
          AuthPasswordInput(
            getPasswordErrors: () => null,
            onPasswordChanged: assignNewPassword,
            autoFocus: true,
            hintText: AppLocalizations.of(context).newPassword,
          ),
          const SizedBox(height: 15),
          AuthPasswordInput(
            getPasswordErrors: () => null,
            onPasswordChanged: assignConfirmNewPassword,
            hintText: AppLocalizations.of(context).confirmNewPassword,
          ),
          const SizedBox(height: 25),
          StatefulBuilder(builder: (context, setState) {
            return SubmitButton(
                isLoading: isLoading,
                onSubmitted: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (newPassword != confirmNewPassword) {
                    showToast(AppLocalizations.of(context).passwordsDontMatch);
                    return;
                  }

                  var result = await submitPassword(newPassword);

                  result.fold((SignUpFailure e) {
                    setState(() {
                      isLoading = false;
                    });
                    showToast(e.message);
                  }, (_) {
                    setState(() {
                      isLoading = false;
                    });
                    showToast(
                        AppLocalizations.of(context).passwordResetSuccessful);
                    Navigator.pop(context);
                  });
                },
                buttonText: AppLocalizations.of(context).submit);
          })
        ],
      ),
    ),
  );
}
