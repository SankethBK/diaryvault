import 'package:dairy_app/core/constants/exports.dart';

import '../../features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
    required this.authSessionBloc,
  }) : super(key: key);

  final AuthSessionBloc authSessionBloc;

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
          onPressed: () async {
            bool? result = await showCustomDialog(
              context: context,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      AppLocalizations.of(context).areYouSureAboutLoggingOut,
                      style: TextStyle(fontSize: 16.0, color: mainTextColor),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CancelButton(
                          buttonText: "Cancel",
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                        const SizedBox(width: 10),
                        SubmitButton(
                          isLoading: false,
                          onSubmitted: () => Navigator.pop(context, true),
                          buttonText: "Logout",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );

            if (result == true) {
              authSessionBloc.add(UserLoggedOut());
            }
          },
          icon: const Icon(Icons.power_settings_new_rounded)),
    );
  }
}
