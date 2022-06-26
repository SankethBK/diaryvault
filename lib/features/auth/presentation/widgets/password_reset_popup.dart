import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:flutter/material.dart';

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

  void startResetPasswordProcess() async {
    if (newPassword != confirmNewPassword) {
      showToast("Passwords don't match");
      return;
    }

    var result = await submitPassword(newPassword);

    result.fold((SignUpFailure e) {
      showToast(e.message);
    }, (_) {
      showToast("password reset successful");
    });
  }

  return showCustomDialog(
    context: context,
    child: Container(
      width: 300,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Reset password",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          AuthPasswordInput(
            getPasswordErrors: () {},
            onPasswordChanged: assignNewPassword,
            autoFocus: true,
            hintText: "New password",
          ),
          const SizedBox(height: 15),
          AuthPasswordInput(
            getPasswordErrors: () {},
            onPasswordChanged: assignConfirmNewPassword,
            hintText: "Confirm new password",
          ),
          const SizedBox(height: 25),
          SubmitButton(
              isLoading: false,
              onSubmitted: startResetPasswordProcess,
              buttonText: "Submit")
        ],
      ),
    ),
  );
}
