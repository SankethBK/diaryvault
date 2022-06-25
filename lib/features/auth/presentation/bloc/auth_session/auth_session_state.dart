part of 'auth_session_bloc.dart';

abstract class AuthSessionState extends Equatable {
  final LoggedInUser? user;

  const AuthSessionState({required this.user});

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthSessionState {
  final bool sessionTimeoutLogout;
  const Unauthenticated({this.sessionTimeoutLogout = false})
      : super(user: null);
}

class Authenticated extends AuthSessionState {
  final bool freshLogin;
  const Authenticated({required LoggedInUser user, this.freshLogin = true})
      : super(user: user);
}
