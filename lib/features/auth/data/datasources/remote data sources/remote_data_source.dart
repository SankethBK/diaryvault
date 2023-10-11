import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final log = printer("AuthRemoteDataSource");

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  late Client appwriteClient;
  final String appwriteProjectId = dotenv.env['APPWRITE_ID'] ?? "";

  AuthRemoteDataSource() {
    appwriteClient = Client();
    appwriteClient
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject(appwriteProjectId)
        .setSelfSigned(status: true);
  }

  @override
  Future<LoggedInUserModel> signUpUser(
      {required String email, required String password}) async {
    log.i("signing up to Appwrite");

    try {
      final account = Account(appwriteClient);

      final user = await account.create(
          userId: ID.unique(), email: email, password: password);

      return LoggedInUserModel(id: user.$id, email: user.email);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<LoggedInUserModel> signInUser(
      {required String email, required String password}) async {
    log.i("Logging in to Appwrite");
    try {
      final account = Account(appwriteClient);

      final session = await account.createEmailSession(
        email: email,
        password: password,
      );
      return LoggedInUserModel(id: session.userId, email: email);
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
      // 1. Login to Appwrite
      final account = Account(appwriteClient);

      await account.createEmailSession(
        email: email,
        password: oldPassword,
      );
      // 2.Update password
      await account.updatePassword(
          oldPassword: oldPassword, password: newPassword);
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }

  @override
  Future<void> submitForgotPasswordEmail(String forgotPasswordEmail) async {
    log.i("Sending forgot password email");

    await Account(appwriteClient).createRecovery(
      email: forgotPasswordEmail,
      url: 'https://diaryvault.netlify.app/reset-password', // Use the full URL
    );
  }

  @override
  Future<void> updateEmail({
    required String oldEmail,
    required String password,
    required String newEmail,
  }) async {
    log.i("updating email in remote");

    try {
      final account = Account(appwriteClient);

      await account.createEmailSession(
        email: oldEmail,
        password: password,
      );

      await account.updateEmail(
        email: newEmail,
        password: password,
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}
