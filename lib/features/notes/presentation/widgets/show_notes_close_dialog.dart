import 'package:dairy_app/core/constants/exports.dart';

Future<dynamic> showCloseDialog(BuildContext context) {
  final mainTextColor =
      Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

  return showCustomDialog(
    context: context,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            AppLocalizations.of(context).youHaveUnsavedChanges,
            style: TextStyle(
              fontSize: 18.0,
              color: mainTextColor,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              CancelButton(
                buttonText: "Leave",
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              const SizedBox(width: 10),
              SubmitButton(
                isLoading: false,
                onSubmitted: () => Navigator.pop(context, false),
                buttonText: "Stay",
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
