part of 'auth_form_bloc.dart';

abstract class AuthFormState extends Equatable {
  final String email;
  final String password;

  const AuthFormState({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthFormInitial extends AuthFormState {
  const AuthFormInitial({required String email, required String password})
      : super(email: email, password: password);
}

class AuthFormSubmissionLoading extends AuthFormState {
  const AuthFormSubmissionLoading(
      {required String email, required String password})
      : super(email: email, password: password);
}

class AuthFormSubmissionSuccessful extends AuthFormState {
  const AuthFormSubmissionSuccessful(
      {required String email, required String password})
      : super(email: email, password: password);
}

class AuthFormSubmissionFailed extends AuthFormState {
  final Map<String, List> errors;

  const AuthFormSubmissionFailed(
      {required String email, required String password, required this.errors})
      : super(email: email, password: password);

  @override
  String toString() {
    return "AuthFormSubmissionFailed(email: $email, password: $password, errors: $errors)";
  }

  @override
  List<Object> get props => [email, password, errors];
}
