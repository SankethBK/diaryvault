import 'package:dairy_app/core/errors/validation_exceptions.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/usecase/usecase_template.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/core/validators/email_validator.dart';
import 'package:dairy_app/features/auth/core/validators/password_validator.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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
