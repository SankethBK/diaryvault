import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthenticationRepository {
  /// If connected to internet, registers the user remotely, and then registers the
  /// user locally using the id returned, for offline logins
  ///
  /// Returns [SignupFailure] Either type with suitable error code
  Future<Either<SignUpFailure, LoggedInUser>> signUpWithEmailAndPassword(
      {required String email, required String password});
}
