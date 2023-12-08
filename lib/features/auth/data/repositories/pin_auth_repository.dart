import 'dart:convert';
import 'dart:async';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';

final log = printer("PINAuthRepository");

class PINAuthRepository {
  final IKeyValueDataSource keyValueDataSource;
  final AuthSessionBloc authSessionBloc;
  final IAuthenticationRepository authenticationRepository;
  // ignore: prefer_const_constructors
  final storage = FlutterSecureStorage();
  PINAuthRepository({
    required this.keyValueDataSource,
    required this.authSessionBloc,
    required this.authenticationRepository,
  });
  Future<void> savePIN(String userId, String pin) async {
    // Hash the pin before storing it for security reasons
    var bytes = utf8.encode(pin); // data being hashed
    var hashedPIN = sha256.convert(bytes).toString();

    // Store the hashed pin with the userId as part of the key
    await storage.write(key: '${userId}_PIN', value: hashedPIN);
  }

  Future<bool> isPINStored(String userId) async {
    String? storedPIN = await storage.read(key: '${userId}_PIN');
    return storedPIN != null;
  }

  /// Checks if UI can submit through accessing user_id in user_config
  String? getUserId() {
    String? userId = keyValueDataSource.getValue(Global.lastLoggedInUser);
    if (userId != null) {
      return userId;
    } else {
      return null;
    }
  }

  /// Checks if UI can use pin auth, based on last logged in user's preferences (if available)
  bool shouldredirectToPINAuthScreen() {
    try {
      log.i("Checking for activating pin");
      // see if lastLoggedInUser is present
      String? lastLoggedInUser =
          keyValueDataSource.getValue(Global.lastLoggedInUser);

      log.d("lastLoggedInUser = $lastLoggedInUser");

      if (lastLoggedInUser == null) {
        return false;
      }

      // See if userConfig is present for last logged in user
      String? userConfigData = keyValueDataSource.getValue(lastLoggedInUser);

      log.d("userConfig = $userConfigData");

      if (userConfigData == null) {
        return false;
      }

      var userConfig = UserConfigModel.fromJson(jsonDecode(userConfigData));

      return userConfig.isPINLoginEnabled == true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }

  Future<bool> verifyPIN(String userId, String pin) async {
    // Hash the pin for verification
    var bytes = utf8.encode(pin); // data being hashed
    var hashedPIN = sha256.convert(bytes).toString();

    // Retrieve the hashed pin using the userId
    String? storedHashedPIN = await storage.read(key: '${userId}_PIN');

    // Return true if the hashed pin matches the stored hashed pin
    return storedHashedPIN == hashedPIN;
  }

  Future<void> deletePIN(String userId) async {
    // Delete the pin for the user
    await storage.delete(key: '${userId}_PIN');
  }
}
