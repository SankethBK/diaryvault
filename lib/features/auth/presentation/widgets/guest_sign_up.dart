import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';

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
