import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';

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
          Text(AppLocalizations.of(context).enterRegisteredEmail,
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
                  showToast(AppLocalizations.of(context).passwordResetMailSent);
                  Navigator.of(context).pop();
                });
              },
              buttonText: AppLocalizations.of(context).submit,
            );
          })
        ],
      ),
    ),
  );
}
