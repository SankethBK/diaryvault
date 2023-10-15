import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';

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
          Text(AppLocalizations.of(context).enterNewEmail,
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
                  showToast(
                      AppLocalizations.of(context).emailUpdatedSuccessfully);
                  await Future.delayed(const Duration(milliseconds: 500));
                  Navigator.of(context).pop(true);
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
