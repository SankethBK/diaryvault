import 'package:dairy_app/core/errors/validation_exceptions.dart';
import 'package:dairy_app/core/validators/validtor_template.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/core/usecase/usecase_template.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class SignInWithEmailAndPassword implements UseCase<LoggedInUser, Params> {
  final Validator emailValidator;
  final IAuthenticationRepository authenticationRepository;

  SignInWithEmailAndPassword(
      {required this.emailValidator, required this.authenticationRepository});

  /// Validates [email]  and continues sign in process by calling repository's
  /// signUpWithEmailAndPassword method
  @override
  Future<Either<SignInFailure, LoggedInUser>> call(Params params) {
    try {
      emailValidator(params.email);
    } on InvalidEmailException {
      return Future.value(Left(SignInFailure.invalidEmail()));
    }

    return authenticationRepository.signInWithEmailAndPassword(
        email: params.email, password: params.password);
  }
}

class Params {
  final String email;
  final String password;

  Params({required this.email, required this.password});
}
