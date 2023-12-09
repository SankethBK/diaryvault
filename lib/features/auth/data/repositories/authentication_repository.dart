import 'package:appwrite/appwrite.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/core/errors/validation_exceptions.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/network/network_info.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/core/validators/email_validator.dart';
import 'package:dairy_app/features/auth/core/validators/password_validator.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

final log = printer("AuthenticationRepository");

class AuthenticationRepository implements IAuthenticationRepository {
  final INetworkInfo networkInfo;
  final IAuthRemoteDataSource remoteDataSource;
  final IAuthLocalDataSource localDataSource;
  final PasswordValidator passwordValidator;
  final EmailValidator emailValidator;

  final LocalAuthentication auth = LocalAuthentication();

  AuthenticationRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.passwordValidator,
    required this.emailValidator,
  });

  @override
  Future<Either<SignUpFailure, LoggedInUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    log.i("signUpWithEmailAndPassword - [$email, $password]");

    if (await networkInfo.isConnected) {
      late LoggedInUser user;
      try {
        user =
            await remoteDataSource.signUpUser(email: email, password: password);
      } on AppwriteException catch (e) {
        log.w(
            "signup failed because of remote exception ${e.code} ${e.message} ${e.type}");

        switch (e.type) {
          case 'user_already_exists':
          case 'user_email_already_exists':
            return Left(SignUpFailure.emailAlreadyExists());
          case 'general_argument_invalid':
            return Left(
                SignUpFailure.invalidPassword("choose a strong password"));
          case 'password_personal_data':
            return Left(SignUpFailure.invalidPassword(
                "password cannot be similar to email"));

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
        log.i("signup successful");

        return Right(user);
      } on DatabaseInsertionException {
        log.e("sign up failed becuase of database exception");

        return Left(SignUpFailure.unknownError());
      }
    }
    log.w("sign up failed because of no internet");
    return Left(SignUpFailure.noInternetConnection());
  }

  /// helper method used by [signInWithEmailAndPassword] to prevent nested code
  Future<Either<SignInFailure, LoggedInUser>> _remoteLogin(
      {required String email, required String password}) async {
    late LoggedInUser user;
    log.i("signInWithEmailAndPassword - [$email, $password]");

    if (await networkInfo.isConnected) {
      try {
        user = await remoteDataSource.signInUser(
          email: email,
          password: password,
        );

        log.i("sign in successful, from remote database $user");

        try {
          await localDataSource.cacheUser(
              id: user.id, email: email, password: password);
        } on DatabaseInsertionException {
          //! silently fail for this exception, as it is not critical

          log.e("caching of user into local db failed");
        }

        return Right(user);
      } on AppwriteException catch (e) {
        log.w("sign in failed because of remote database exception ${e.type}");

        switch (e.type) {
          case 'user_invalid_credentials':
            return Left(
                SignInFailure.wrongPassword("email or password is incorrect"));
          case 'general_argument_invalid':
            return Left(SignInFailure.wrongPassword(
                "password must be atleast 8 characters"));
          case 'user_blocked':
            return Left(SignInFailure.userDisabled());
          default:
            return Left(SignInFailure.unknownError());
        }
      }
    }
    log.w("sign in failed because of no internet");

    return Left(SignInFailure.noInternetConnection());
  }

  @override
  Future<Either<SignInFailure, LoggedInUser>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    late LoggedInUser user;
    try {
      user = await localDataSource.signInUser(email: email, password: password);
      log.i("sign in successful, from local database $user");

      return Right(user);
    } on SignInFailure catch (e) {
      log.e("sign in failed because of incorrect credentails $e.code");
      switch (e.code) {
        case SignInFailure.WRONG_PASSWORD:
          return _remoteLogin(email: email, password: password);
        case SignInFailure.EMAIL_DOES_NOT_EXISTS:
          return _remoteLogin(email: email, password: password);
        default:
          return Left(SignInFailure.unknownError());
      }
    } on DatabaseQueryException {
      log.e("sign in failed because of local database exception");

      return Left(SignInFailure.unknownError());
    }
  }

  @override
  Future<bool> verifyPassword(String userId, String password) async {
    try {
      return localDataSource.verifyPassword(userId, password);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<SignUpFailure, bool>> updatePassword(
      String email, String oldPassword, String newPassword) async {
    // step 1: validation

    try {
      passwordValidator(newPassword);
    } on InvalidPasswordException catch (e) {
      return Left(SignUpFailure.invalidPassword(e.message));
    }

    try {
      // step 2. Update the password in remote
      await remoteDataSource.updatePassword(
        email: email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      // step 3: Reset the password in local
      await localDataSource.updatePassword(
        email: email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      log.e(e);
      return Left(SignUpFailure.unknownError());
    }

    return const Right(true);
  }

  @override
  Future<void> isFingerprintAuthPossible() async {
    bool hasBiometrics = await auth.canCheckBiometrics;
    log.i("hasBIometrics = $hasBiometrics");
    if (hasBiometrics == false) {
      throw Exception("device doesn't support fingerprint");
    }

    var availableBiometrics = await auth.getAvailableBiometrics();
    log.i("available biometrics = $availableBiometrics");

    bool hasFingerprintSetup =
        availableBiometrics.contains(BiometricType.strong) ||
            availableBiometrics.contains(BiometricType.fingerprint);

    if (!hasFingerprintSetup) {
      throw Exception("please setup fingerprint in device settings");
    }
  }

  @override
  Stream<FingerPrintAuthState> processFingerPrintAuth() async* {
    log.i("Started processing fingerprint auth");

    while (true) {
      try {
        var authenticationResult = await auth.authenticate(
          localizedReason: 'Scan Fingerprint to Authenticate',
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true),
        );

        if (authenticationResult == false) {
          yield FingerPrintAuthState.fail;
        } else if (authenticationResult == true) {
          await auth.stopAuthentication();
          yield FingerPrintAuthState.success;
        }

        // need to free the thread for other tasks
        await Future.delayed(const Duration(milliseconds: 500));
      } on PlatformException catch (e) {
        log.e(e);
        auth.stopAuthentication();
      }
    }
  }

  @override
  Future<Either<SignInFailure, LoggedInUser>> signInDirectly(
      {required String userId}) async {
    try {
      log.i("Starting passwordless sign in");
      LoggedInUser user = await localDataSource.signInDirectly(userId: userId);
      return Right(user);
    } catch (e) {
      log.e(e);
      return Left(SignInFailure.unknownError());
    }
  }

  @override
  Future<Either<ForgotPasswordFailure, bool>> submitForgotPasswordEmail(
      String forgotPasswordEmail) async {
    try {
      emailValidator(forgotPasswordEmail);

      if (await networkInfo.isConnected) {
        await remoteDataSource.submitForgotPasswordEmail(forgotPasswordEmail);
        return const Right(true);
      }
      return Left(ForgotPasswordFailure.noInternetConnection());
    } on AppwriteException catch (e) {
      log.e(e);

      if (e.type == "user_not_found") {
        return Left(ForgotPasswordFailure.userNotFound());
      }
      return Left(ForgotPasswordFailure.unknownError());
    } on InvalidEmailException catch (e) {
      log.e(e);
      return Left(ForgotPasswordFailure.invalidEmail(e.message));
    } catch (e) {
      log.e(e);
      return Left(ForgotPasswordFailure.unknownError());
    }
  }

  @override
  Future<Either<SignUpFailure, bool>> updateEmail(
      {required String oldEmail,
      required String password,
      required String newEmail}) async {
    // step 1: validation

    try {
      emailValidator(newEmail);
    } on InvalidEmailException catch (e) {
      return Left(SignUpFailure.invalidEmail(e.message));
    }

    try {
      // step 2. Update the email in remote
      await remoteDataSource.updateEmail(
        oldEmail: oldEmail,
        password: password,
        newEmail: newEmail,
      );

      // step 3: Reset the password in local
      await localDataSource.updateEmail(
        oldEmail: oldEmail,
        password: password,
        newEmail: newEmail,
      );
    } on AppwriteException catch (e) {
      log.e(e.type);

      if (e.type == "user_email_already_exists") {
        return Left(SignUpFailure.emailAlreadyExists());
      }

      return Left(SignUpFailure.unknownError());
    } catch (e) {
      log.e(e);
      return Left(SignUpFailure.unknownError());
    }

    return const Right(true);
  }
}
