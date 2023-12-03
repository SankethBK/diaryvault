import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'pin_input_field.dart';
import 'package:dairy_app/features/auth/data/repositories/PINAuthRepository.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';

Future<dynamic> pinResetPopup(
    {required BuildContext context, required String userPinId}) {
  String newPin = "";
  String confirmNewPin = "";
  String userId = userPinId;
  final pinAuthRepository = sl<PINAuthRepository>();

  void assignNewPin(String val) {
    newPin = val;
  }

  void assignConfirmNewPin(String val) {
    confirmNewPin = val;
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
          Text(S.current.resetPin,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: mainTextColor)),
          const SizedBox(height: 25),
          AuthPinInput(
            getPinErrors: () => null,
            onPinChanged: assignNewPin,
            autoFocus: true,
            hintText: S.current.enterNewPin,
          ),
          const SizedBox(height: 15),
          AuthPinInput(
            getPinErrors: () => null,
            onPinChanged: assignConfirmNewPin,
            hintText: S.current.confirmNewPin,
          ),
          const SizedBox(height: 25),
          StatefulBuilder(builder: (context, setState) {
            return SubmitButton(
                isLoading: isLoading,
                onSubmitted: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (newPin != confirmNewPin) {
                    showToast(S.current.pinsDontMatch);
                    setState(() => isLoading = false);
                    return;
                  }
                  // Use the provided submitPin function to handle the new PIN
                  await pinAuthRepository.savePIN(userId, newPin);

                  setState(() => isLoading = false);
                  Navigator.pop(context);
                },
                buttonText: S.current.submit);
          })
        ],
      ),
    ),
  );
}
