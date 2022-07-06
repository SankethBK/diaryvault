import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dartz/dartz.dart';

enum FingerPrintAuthState {
  success,
  fail,
  platformError,
  attemptsExceeded,
}

abstract class IAuthenticationRepository {
  /// If connected to internet, registers the user remotely, and then registers the
  /// user locally using the id returned, for offline logins
  ///
  /// Returns [SignupFailure] Either type with suitable error code
  Future<Either<SignUpFailure, LoggedInUser>> signUpWithEmailAndPassword(
      {required String email, required String password});

  /// First tries to sign in from local database, if the email is not found in
  /// local database, then tries to sign in through firebase
  ///
  /// If the [email] is present in local database, but password is not matching
  /// then it will not check into firebase but throws [SignInFailure]
  ///
  /// id the [email] is not present in local database, then it logs in with firebase
  /// and stores the [email] and [password] in local database for subsequent logins.
  Future<Either<SignInFailure, LoggedInUser>> signInWithEmailAndPassword(
      {required String email, required String password});

  /// Used to verify password, email is not avialable at that place, so userId is used.
  Future<bool> verifyPassword(String userId, String password);

  /// update password in both rmeote and local
  Future<Either<SignUpFailure, bool>> updatePassword(
      String email, String oldPassword, String newPassword);

  /// based on device configuration, returns if fingerprint auth is possible
  /// fingerprint auth should be both available and set
  Future<void> isFingerprintAuthPossible();

  /// Listens for fingerprint events, and returns a stream of bool values
  /// null inidcates some error occured while doing so
  Stream<FingerPrintAuthState> processFingerPrintAuth();

  /// Login without password (authentication will be carried out by fingerprint)
  Future<Either<SignInFailure, LoggedInUser>> signInDirectly(
      {required String userId});

  /// Send forgot password email
  Future<Either<ForgotPasswordFailure, bool>> submitForgotPasswordEmail(
      String forgotPasswordEmail);

  // update email in both remote and local
  Future<Either<SignUpFailure, bool>> updateEmail(
      {required String oldEmail,
      required String password,
      required String newEmail});
}
