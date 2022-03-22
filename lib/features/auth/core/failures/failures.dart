import '../../../../core/failure.dart';
import 'failure_codes.dart';

class SignUpFailure extends Failure {
  const SignUpFailure._({required String message, required int code})
      : super(message: message, code: code);

  factory SignUpFailure.invalidEmail() {
    return const SignUpFailure._(
        message: "invalid email", code: SignUpFailureCodes.INVALID_EMAIL);
  }

  factory SignUpFailure.emailAlreadyExists() {
    return const SignUpFailure._(
        message: "email already exissts",
        code: SignUpFailureCodes.EMAIL_ALREADY_EXISTS);
  }
}
