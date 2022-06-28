import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/presentation/widgets/email_input_field.dart';
import 'package:flutter/material.dart';

Future<void> forgotPasswordPopup(
    BuildContext context, Function(String) submitForgotPassword) {
  String forgotPasswordEmail = "";

  void submitForgotPasswordEmail() async {
    var result = await submitForgotPassword(forgotPasswordEmail);

    result.fold((ForgotPasswordFailure e) {
      showToast(e.message);
    }, (_) {
      showToast("password reset email sent");
      Navigator.of(context).pop();
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
          const Text("Enter registered email",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          AuthEmailInput(
            autoFocus: true,
            getEmailErrors: () {},
            onEmailChanged: (String email) {
              forgotPasswordEmail = email;
            },
          ),
          const SizedBox(height: 25),
          SubmitButton(
            isLoading: false,
            onSubmitted: submitForgotPasswordEmail,
            buttonText: "Submit",
          )
        ],
      ),
    ),
  );
}
