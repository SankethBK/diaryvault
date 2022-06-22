part of 'auth_session_bloc.dart';

abstract class AuthSessionState extends Equatable {
  final LoggedInUser? user;

  const AuthSessionState({required this.user});

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthSessionState {
  const Unauthenticated() : super(user: null);
}

class Authenticated extends AuthSessionState {
  const Authenticated({required LoggedInUser user}) : super(user: user);
}
