import '../../../../core/failure.dart';

class SignUpFailure extends Failure {
  static const INVALID_EMAIL = 0;
  static const EMAIL_ALREADY_EXISTS = 1;

  const SignUpFailure._({required String message, required int code})
      : super(message: message, code: code);

  factory SignUpFailure.invalidEmail() {
    return const SignUpFailure._(message: "invalid email", code: INVALID_EMAIL);
  }

  factory SignUpFailure.emailAlreadyExists() {
    return const SignUpFailure._(
        message: "email already exissts", code: EMAIL_ALREADY_EXISTS);
  }
}
