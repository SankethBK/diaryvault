part of 'auth_session_bloc.dart';

abstract class AuthSessionState extends Equatable {
  const AuthSessionState();

  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthSessionState {}

class Authenticated extends AuthSessionState {
  final LoggedInUser user;

  const Authenticated({required this.user});
}
