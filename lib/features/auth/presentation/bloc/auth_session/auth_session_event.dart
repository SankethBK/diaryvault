part of 'auth_session_bloc.dart';

abstract class AuthSessionEvent extends Equatable {
  const AuthSessionEvent();

  @override
  List<Object> get props => [];
}

class AppLostFocus extends AuthSessionEvent {}

class UserLoggedIn extends AuthSessionEvent {
  final LoggedInUser user;

  const UserLoggedIn({required this.user});
}

class UserLoggedOut extends AuthSessionEvent {}
