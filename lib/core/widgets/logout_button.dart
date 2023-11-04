import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';

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
                      S.current.areYouSureAboutLoggingOut,
                      style: TextStyle(fontSize: 16.0, color: mainTextColor),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CancelButton(
                          buttonText: S.current.cancel,
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                        const SizedBox(width: 10),
                        SubmitButton(
                          isLoading: false,
                          onSubmitted: () => Navigator.pop(context, true),
                          buttonText: S.current.logOut2,
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
