import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_input_field.dart';
import 'package:flutter/material.dart';

Future<dynamic> passwordLoginPopup(
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
      await Future.delayed(const Duration(milliseconds: 300));
      Navigator.of(context).pop(password);
    }
  }

  return showCustomDialog(
      context: context,
      child: Container(
        height: 230,
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const Text("Enter current password",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          AuthPasswordInput(
            getPasswordErrors: () {},
            onPasswordChanged: assignPassword,
            autoFocus: true,
          ),
          const SizedBox(height: 25),
          SubmitButton(
              isLoading: false,
              onSubmitted: verifyPassword,
              buttonText: "Submit")
        ]),
      ));
}
