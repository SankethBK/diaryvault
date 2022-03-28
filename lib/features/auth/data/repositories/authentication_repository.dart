import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/core/network/network_info.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final NetworkInfo networkInfo;
  final IRemoteDataSource remoteDataSource;
  final ILocalDataSource localDataSource;

  AuthenticationRepository(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<SignUpFailure, LoggedInUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      late LoggedInUser user;
      try {
        user =
            await remoteDataSource.signUpUser(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'email-already-in-use':
            return Left(SignUpFailure.emailAlreadyExists());
          case 'invalid-email':
            return Left(SignUpFailure.invalidEmail());
          case 'weak-password':
            return Left(SignUpFailure.invalidPassword(
                "password must be atleast 6 characters"));
          default:
            return Left(SignUpFailure.unknownError());
        }
      }

      try {
        user = await localDataSource.signUpUser(
          id: user.id,
          email: email,
          password: password,
        );
        return Right(user);
      } on DatabaseInsertionException catch (e) {
        return Left(SignUpFailure.unknownError());
      }
    }

    return Left(SignUpFailure.noInternetConnection());
  }

  /// helper method used by [signInWithEmailAndPassword] to prevent nested code
  Future<Either<SignInFailure, LoggedInUser>> _remoteLogin(
      {required String email, required String password}) async {
    late LoggedInUser user;

    if (await networkInfo.isConnected) {
      try {
        user = await remoteDataSource.signInUser(
          email: email,
          password: password,
        );
        return Right(user);
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'invalid-email':
            return Left(SignInFailure.invalidEmail());
          case 'user-disabled':
            return Left(SignInFailure.userDisabled());
          case 'user-not-found':
            return Left(SignInFailure.emailDoesNotExists());
          case 'wrong-password':
            return Left(SignInFailure.wrongPassword());
          default:
            return Left(SignInFailure.unknownError());
        }
      }
    }
    return Left(SignInFailure.noInternetConnection());
  }

  @override
  Future<Either<SignInFailure, LoggedInUser>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    late LoggedInUser user;
    try {
      user = await localDataSource.signInUser(email: email, password: password);
      return Right(user);
    } on SignInFailure catch (e) {
      switch (e.code) {
        case SignInFailure.WRONG_PASSWORD:
          return Left(SignInFailure.wrongPassword());
        case SignInFailure.EMAIL_DOES_NOT_EXISTS:
          return _remoteLogin(email: email, password: password);
        default:
          return Left(SignInFailure.unknownError());
      }
    } on DatabaseQueryException {
      return Left(SignInFailure.unknownError());
    }
  }
}
