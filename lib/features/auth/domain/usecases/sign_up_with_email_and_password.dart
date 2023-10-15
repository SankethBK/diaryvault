import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';
import 'package:dartz/dartz.dart';

final log = printer("AuthSignupUseCase");

class SignUpWithEmailAndPassword
    implements UseCase<LoggedInUser, SignUpParams> {
  final EmailValidator emailValidator;
  final PasswordValidator passwordValidator;
  final IAuthenticationRepository authenticationRepository;

  SignUpWithEmailAndPassword(
      {required this.emailValidator,
      required this.passwordValidator,
      required this.authenticationRepository});

  /// Validates [email] and [password] and continues sign up process by calling repository's
  /// signUpWithEmailAndPassword method
  @override
  Future<Either<SignUpFailure, LoggedInUser>> call(SignUpParams params) {
    log.i(params);

    try {
      emailValidator(params.email);
      passwordValidator(params.password);
    } on InvalidEmailException {
      return Future.value(Left(SignUpFailure.invalidEmail()));
    } on InvalidPasswordException catch (e) {
      return Future.value(Left(SignUpFailure.invalidPassword(e.message)));
    }

    log.d("Input validation passed");

    return authenticationRepository.signUpWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class SignUpParams extends Equatable {
  final String email;
  final String password;

  const SignUpParams({required this.email, required this.password});

  @override
  String toString() {
    return "$email, $password";
  }

  @override
  List<Object?> get props => [email, password];
}
