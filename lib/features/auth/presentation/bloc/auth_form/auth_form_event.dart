part of 'auth_form_bloc.dart';

abstract class AuthFormEvent extends Equatable {
  const AuthFormEvent();

  @override
  List<Object> get props => [];
}

class AuthFormInputsChangedEvent extends AuthFormEvent {
  final String? email;
  final String? password;

  const AuthFormInputsChangedEvent({this.email, this.password});
}

class AuthFormSignUpSubmitted extends AuthFormEvent {}

class AuthFormSignInSubmitted extends AuthFormEvent {
  final String? lastLoggedInUserId;

  const AuthFormSignInSubmitted({this.lastLoggedInUserId});
}

class ResetAuthForm extends AuthFormEvent {}

class AuthFormGuestSignIn extends AuthFormEvent {}

// added to handle direct sign in for pin
class AuthFormSignInDirectlySubmitted extends AuthFormEvent {
  final String userId;
  // ignore: prefer_const_constructors_in_immutables
  AuthFormSignInDirectlySubmitted({required this.userId});

  @override
  List<Object> get props => [userId];
}
