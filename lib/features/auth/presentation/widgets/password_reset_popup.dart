import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:flutter/material.dart';

import 'password_input_field.dart';

Future<dynamic> passwordResetPopup(
    {required BuildContext context, required Function submitPassword}) {
  String password = "";

  void assignPassword(String val) {
    password = val;
  }

  void verifyPassword() async {
    bool result = await submitPassword(password);
    if (result == false) {
      showToast("Incorrect password");
    } else {
      showToast("Password verified");
      Navigator.of(context).pop(true);
    }
  }

  return showCustomDialog(
      context: context,
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const Text("Reset password",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          AuthPasswordInput(
            getPasswordErrors: () {},
            onPasswordChanged: assignPassword,
            autoFocus: true,
            hintText: "New password",
          ),
          const SizedBox(height: 15),
          AuthPasswordInput(
            getPasswordErrors: () {},
            onPasswordChanged: assignPassword,
            hintText: "Confirm new password",
          ),
          const SizedBox(height: 25),
          SubmitButton(
              isLoading: false,
              onSubmitted: verifyPassword,
              buttonText: "Submit")
        ]),
      ));
}
