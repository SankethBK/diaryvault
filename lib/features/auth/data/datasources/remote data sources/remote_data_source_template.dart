import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';

abstract class IAuthRemoteDataSource {
  /// Tried to register user on a remote server
  ///
  /// Throws [FirebaseAuthException] with suitable error codes if something goes wwrong.
  Future<LoggedInUserModel> signUpUser(
      {required String email, required String password});

  /// Tries to sign in user on a remote server by [email] and [password]
  ///
  /// Throws [SignInFailure] with suitable error code if something foes wrong
  Future<LoggedInUserModel> signInUser(
      {required String email, required String password});

  // Update the password in remote
  Future<void> updatePassword(
      {required String email,
      required String oldPassword,
      required String newPassword});

  Future<void> submitForgotPasswordEmail(String forgotPasswordEmail);

  Future<void> updateEmail(
      {required String oldEmail,
      required String password,
      required String newEmail});
}
