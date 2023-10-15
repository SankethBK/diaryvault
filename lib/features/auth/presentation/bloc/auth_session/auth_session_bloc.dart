import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';
import 'package:dairy_app/features/sync/core/exports.dart';

part 'auth_session_event.dart';
part 'auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  final IKeyValueDataSource keyValueDataSource;

  AuthSessionBloc({
    required this.keyValueDataSource,
  }) : super(const Unauthenticated()) {
    final log = printer("AuthSessionBloc");
    log.d("AuthSessionBloc recreated");

    on<InitalizeLastLoggedInUser>((event, emit) {
      // check for "last_logged_in_user" from shared preferences. If it is equal to "guest_user_id",
      // then don't show authentication page as guest user only comes with limited set of features

      String? lastLoggedInUserId =
          keyValueDataSource.getValue(Global.lastLoggedInUser);

      if (lastLoggedInUserId != null &&
          lastLoggedInUserId == GuestUserDetails.guestUserId) {
        emit(Authenticated(
            user: LoggedInUser.getGuestUserModel(), freshLogin: true));
      } else {
        emit(Unauthenticated(lastLoggedInUserId: lastLoggedInUserId));
      }
    });

    on<UserLoggedIn>((event, emit) =>
        emit(Authenticated(user: event.user, freshLogin: event.freshLogin)));

    on<UserLoggedOut>((event, emit) =>
        emit(Unauthenticated(lastLoggedInUserId: state.user?.id)));

    // navigation will be handled differently for session timeout logouts
    //! These 2 states aren't used as of now
    on<AppLostFocus>((event, emit) {
      if (state is Authenticated) {
        emit(const Unauthenticated(sessionTimeoutLogout: true));
      }
    });

    on<AppSessionTimeout>((event, emit) {
      if (state is Authenticated) {
        emit(const Unauthenticated(sessionTimeoutLogout: true));
      }
    });
  }
}
