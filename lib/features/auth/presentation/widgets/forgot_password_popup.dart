import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/presentation/widgets/email_input_field.dart';
import 'package:flutter/material.dart';

Future<void> forgotPasswordPopup(
    BuildContext context, Function(String) submitForgotPassword) {
  String forgotPasswordEmail = "";

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
          Text("Enter registered email",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: mainTextColor,
              )),
          const SizedBox(height: 25),
          AuthEmailInput(
            autoFocus: true,
            getEmailErrors: () => null,
            onEmailChanged: (String email) {
              forgotPasswordEmail = email;
            },
          ),
          const SizedBox(height: 25),
          StatefulBuilder(builder: (context, setState) {
            return SubmitButton(
              isLoading: isLoading,
              onSubmitted: () async {
                setState(() {
                  isLoading = true;
                });

                var result = await submitForgotPassword(forgotPasswordEmail);

                result.fold((ForgotPasswordFailure e) {
                  setState(() {
                    isLoading = false;
                  });
                  showToast(e.message);
                }, (_) {
                  setState(() {
                    isLoading = false;
                  });
                  showToast("password reset email sent");
                  Navigator.of(context).pop();
                });
              },
              buttonText: "Submit",
            );
          })
        ],
      ),
    ),
  );
}
