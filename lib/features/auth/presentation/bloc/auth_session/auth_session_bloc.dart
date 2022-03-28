import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_session_event.dart';
part 'auth_session_state.dart';

class AuthSessionBloc extends Bloc<AuthSessionEvent, AuthSessionState> {
  final IAuthenticationRepository _authenticationRepository;
  late StreamSubscription<LoggedInUser?> _authenticationStatusSubscription;

  AuthSessionBloc({required IAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(Unauthenticated()) {
    _authenticationStatusSubscription =
        _authenticationRepository.authStateStream.listen((user) {});

    on<AuthSessionEvent>(
      (event, emit) {},
    );

    @override
    // ignore: unused_element
    Future<void> close() {
      _authenticationStatusSubscription.cancel();
      _authenticationRepository.dispose();
      return super.close();
    }
  }
}
