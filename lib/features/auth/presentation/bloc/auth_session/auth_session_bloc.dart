import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:equatable/equatable.dart';

part 'auth_session_event.dart';
part 'auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  final IKeyValueDataSource keyValueDataSource;

  AuthSessionBloc({
    required this.keyValueDataSource,
  }) : super(const Unauthenticated()) {
    final log = printer("AuthSessionBloc");
    log.d("AuthSessionBloc recreated");

    // check for "last_logged_in_user" from shared preferences. If it is equal to "guest_user_id",
    // then don't show authentication page as guest user only comes with limited set of features

    String? lastLoggedInUserId =
        keyValueDataSource.getValue(Global.lastLoggedInUser);

    // if (lastLoggedInUserId != null &&
    //     lastLoggedInUserId == GuestUserDetails.guestUserId) {
    emit(Authenticated(
        user: LoggedInUser.getGuestUserModel(), freshLogin: true));
    // }

    on<UserLoggedIn>((event, emit) =>
        emit(Authenticated(user: event.user, freshLogin: event.freshLogin)));

    on<UserLoggedOut>((event, emit) => emit(const Unauthenticated()));

    // navigation will be handled differently for session timeout logouts
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
