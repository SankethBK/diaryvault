import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
