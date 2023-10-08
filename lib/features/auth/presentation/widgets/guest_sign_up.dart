import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GuestSignUp extends StatelessWidget {
  const GuestSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final linkColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;
    return BlocBuilder<AuthSessionBloc, AuthSessionState>(
      builder: (context, state) {
        // If lastLoggedInUserId is a already a valid user id, don't show guest_sign_up
        // as user already has completed the account setup
        if (state is Unauthenticated) {
          final lastLoggedInUserId = state.lastLoggedInUserId;
          // show this option only for new users or previously logged in guest users
          if (lastLoggedInUserId == null ||
              lastLoggedInUserId == GuestUserDetails.guestUserId) {
            return GestureDetector(
              onTap: () {
                final authFormbloc = BlocProvider.of<AuthFormBloc>(context);
                authFormbloc.add(AuthFormGuestSignIn());
              },
              child: Text(
                AppLocalizations.of(context).continueAsGues,
                style: TextStyle(
                  color: linkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
