import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';

abstract class IRemoteDataSource {
  /// Tried to register user on a remote server
  ///
  /// Throws [SignupFailure] with suitable error codes if something goes wwrong.
  Future<LoggedInUserModel> signUpUser(
      {required String email, required String password});
}
