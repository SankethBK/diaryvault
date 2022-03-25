import '../../../../core/errors/failure_template.dart';

class SignUpFailure extends Failure {
  static const INVALID_EMAIL = 0;
  static const EMAIL_ALREADY_EXISTS = 1;
  static const INVALID_PASSWORD = 2;

  const SignUpFailure._({required String message, required int code})
      : super(message: message, code: code);

  factory SignUpFailure.invalidEmail([String? message]) {
    return SignUpFailure._(
        message: message ?? "invalid email", code: INVALID_EMAIL);
  }

  factory SignUpFailure.emailAlreadyExists([String? message]) {
    return SignUpFailure._(
        message: message ?? "email already exissts",
        code: EMAIL_ALREADY_EXISTS);
  }

  factory SignUpFailure.invalidPassword(String? message) {
    return SignUpFailure._(
        message: message ?? "invalid password", code: INVALID_PASSWORD);
  }
}
