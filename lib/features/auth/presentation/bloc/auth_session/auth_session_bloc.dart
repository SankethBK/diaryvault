import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_session_event.dart';
part 'auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  AuthSessionBloc() : super(const Unauthenticated()) {
    final log = printer("Router");
    log.d("AuthSessionBloc recreated");

    on<UserLoggedIn>((event, emit) => emit(Authenticated(user: event.user)));
    on<UserLoggedOut>((event, emit) => emit(const Unauthenticated()));
    on<AppLostFocus>(((event, emit) => emit(const Unauthenticated())));
  }
}
