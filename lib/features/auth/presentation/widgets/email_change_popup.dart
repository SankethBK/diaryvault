import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/presentation/widgets/email_input_field.dart';
import 'package:flutter/material.dart';

Future<dynamic> emailChangePopup(
    BuildContext context, Function(String) submitEmailChange) {
  String changedEmail = "";

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
          Text("Enter new email",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: mainTextColor,
              )),
          const SizedBox(height: 25),
          AuthEmailInput(
            autoFocus: true,
            getEmailErrors: () {},
            onEmailChanged: (String email) {
              changedEmail = email;
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

                var result = await submitEmailChange(changedEmail);

                result.fold((SignUpFailure e) {
                  setState(() {
                    isLoading = false;
                  });
                  showToast(e.message);
                }, (_) async {
                  setState(() {
                    isLoading = false;
                  });
                  showToast("email updated successfully, please login again");
                  await Future.delayed(const Duration(milliseconds: 500));
                  Navigator.of(context).pop(true);
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
