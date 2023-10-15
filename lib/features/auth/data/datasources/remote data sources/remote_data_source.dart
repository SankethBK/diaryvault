import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';

final log = printer("AuthRemoteDataSource");

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  @override
  Future<LoggedInUserModel> signUpUser(
      {required String email, required String password}) async {
    log.i("signing up to Firebase");

    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return LoggedInUserModel(
          id: credential.user?.uid as String, email: email);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<LoggedInUserModel> signInUser(
      {required String email, required String password}) async {
    log.i("Logging in to Firebase");
    try {
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return LoggedInUserModel(
          id: credential.user?.uid as String, email: email);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<void> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      log.i("Updating password in Firebase");
      // 1. Login to Firebase
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: oldPassword);

      // 2.Update password
      await credential.user!.updatePassword(newPassword);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<void> submitForgotPasswordEmail(String forgotPasswordEmail) async {
    log.i("Sending forgot password email");

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: forgotPasswordEmail);
  }

  @override
  Future<void> updateEmail({
    required String oldEmail,
    required String password,
    required String newEmail,
  }) async {
    log.i("updating email in remote");

    try {
      var credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: oldEmail, password: password);

      await credential.user!.updateEmail(newEmail);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
