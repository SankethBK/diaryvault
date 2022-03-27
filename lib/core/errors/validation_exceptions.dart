import 'package:dairy_app/core/errors/custom_exception_template.dart';

class InvalidEmailException extends CustomException {
  static const INVALID_EMAIL = 0;

  const InvalidEmailException._({required String message, required int code})
      : super(message: message, code: code);

  factory InvalidEmailException.invalidEmail() {
    return const InvalidEmailException._(
        code: INVALID_EMAIL, message: "invalid email");
  }
}

class InvalidPasswordException extends CustomException {
  static const SHORT_PASWORD = 0;
  static const LONG_PASSWORD = 1;

  const InvalidPasswordException._({required String message, required int code})
      : super(message: message, code: code);

  factory InvalidPasswordException.shortPassword() {
    return const InvalidPasswordException._(
        code: SHORT_PASWORD, message: "password must be atleast 6 characters");
  }

  factory InvalidPasswordException.longPassword() {
    return const InvalidPasswordException._(
        code: LONG_PASSWORD,
        message: "password must not be longer than 20 characters");
  }
}
