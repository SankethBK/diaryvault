import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';

abstract class IAuthLocalDataSource {
  /// Tries ot register the user in local database
  ///
  /// Throws [SignupFailure] with suitable error codes, if something goes wrong
  /// Throws [DatabaseInsertionException] if something related to database goes wrong
  Future<LoggedInUserModel> signUpUser(
      {required id, required String email, required String password});

  /// Tries to sign in user locally by using stored [email] and [password]
  ///
  /// If [email] matches but [password] is invalid then throws [SignInFailure] with suitable error code
  /// if [email] does not exists throws [SignInFailure] with suitable error code
  /// throws [DatabaseQueryException] if db query fails
  Future<LoggedInUserModel> signInUser(
      {required String email, required String password});

  /// stores the user entry in local db for subsequent offline logins
  ///
  /// Throws [DatabaseInsertionException] if something related to database goes wrong
  Future<void> cacheUser(
      {required id, required String email, required String password});

  /// Used to verify password, email is not avialable at that place, so userId is used.
  Future<bool> verifyPassword(String userId, String password);

  /// updates password in local
  Future<void> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  });

  /// passwordless sign in
  Future<LoggedInUserModel> signInDirectly({required String userId});
}
