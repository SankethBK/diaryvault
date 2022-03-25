import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<SignUpFailure, LoggedInUser>> signUpWIthEmailAndPassword(
      {required String email, required String password});
}
