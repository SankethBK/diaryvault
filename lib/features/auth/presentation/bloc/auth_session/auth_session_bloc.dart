import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:equatable/equatable.dart';

part 'auth_session_event.dart';
part 'auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  AuthSessionBloc() : super(Unauthenticated()) {
    on<UserLoggedIn>((event, emit) => emit(Authenticated(user: event.user)));
    on<UserLoggedOut>((event, emit) => emit(Unauthenticated()));
    on<AppLostFocus>(((event, emit) => emit(Unauthenticated())));
  }
}
