import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<SignUpFailure, Unit>> signUpWIthEmailAndPassword(
      {required String email, required String password});
}
