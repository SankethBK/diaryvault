import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';

abstract class ILocalDataSource {
  /// Tries ot register the user in local database
  ///
  /// Throws [SignupFailure] with suitable error codes, if something goes wrong
  Future<LoggedInUserModel> signUpUser(
      {required id, required String email, required String password});
}
