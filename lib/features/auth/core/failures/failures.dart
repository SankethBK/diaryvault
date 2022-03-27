import '../../../../core/errors/failure_template.dart';

class SignUpFailure extends Failure {
  static const UNKNOWN_ERROR = -1;
  static const INVALID_EMAIL = 0;
  static const EMAIL_ALREADY_EXISTS = 1;
  static const INVALID_PASSWORD = 2;
  static const NO_INTERNET_CONNECTION = 3;

  const SignUpFailure._({required String message, required int code})
      : super(message: message, code: code);

  factory SignUpFailure.unknownError([String? message]) {
    return SignUpFailure._(
        message: message ?? "unknown error occured, please try again",
        code: UNKNOWN_ERROR);
  }

  factory SignUpFailure.invalidEmail([String? message]) {
    return SignUpFailure._(
        message: message ?? "invalid email", code: INVALID_EMAIL);
  }

  factory SignUpFailure.emailAlreadyExists([String? message]) {
    return SignUpFailure._(
        message: message ?? "email already exissts",
        code: EMAIL_ALREADY_EXISTS);
  }

  factory SignUpFailure.invalidPassword([String? message]) {
    return SignUpFailure._(
        message: message ?? "invalid password", code: INVALID_PASSWORD);
  }

  factory SignUpFailure.noInternetConnection([String? message]) {
    return SignUpFailure._(
        message: message ?? "please turn on internet for sign up",
        code: NO_INTERNET_CONNECTION);
  }
}

class SignInFailure extends Failure {
  static const UNKNOWN_ERROR = -1;
  static const INVALID_EMAIL = 0;
  static const EMAIL_DOES_NOT_EXISTS = 1;
  static const WRONG_PASSWORD = 2;
  static const NO_INTERNET_CONNECTION = 3;
  static const USER_DISABLED = 4;

  const SignInFailure._({required String message, required int code})
      : super(message: message, code: code);

  factory SignInFailure.unknownError([String? message]) {
    return SignInFailure._(
        message: message ?? "unknown error occured, please try again",
        code: UNKNOWN_ERROR);
  }

  factory SignInFailure.invalidEmail([String? message]) {
    return SignInFailure._(
        message: message ?? "invalid email", code: INVALID_EMAIL);
  }

  factory SignInFailure.emailDoesNotExists([String? message]) {
    return SignInFailure._(
        message: message ?? "email not found", code: EMAIL_DOES_NOT_EXISTS);
  }

  factory SignInFailure.wrongPassword([String? message]) {
    return SignInFailure._(
        message: message ?? "wrong password", code: WRONG_PASSWORD);
  }

  factory SignInFailure.noInternetConnection([String? message]) {
    return SignInFailure._(
        message: message ?? "please turn on internet for first log in",
        code: NO_INTERNET_CONNECTION);
  }

  factory SignInFailure.userDisabled([String? message]) {
    return SignInFailure._(
        message:
            message ?? "user has been banned, please contact customer service",
        code: USER_DISABLED);
  }
}
