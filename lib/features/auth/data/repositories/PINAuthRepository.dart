import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';

class PINAuthRepository {
  final FlutterSecureStorage secureStorage;

  PINAuthRepository({required this.secureStorage});

  Future<void> savePIN(String userId, String pin) async {
    // Hash the pin before storing it for security reasons
    var bytes = utf8.encode(pin); // data being hashed
    var hashedPIN = sha256.convert(bytes).toString();

    // Store the hashed pin with the userId as part of the key
    await secureStorage.write(key: '${userId}_PIN', value: hashedPIN);
  }

  Future<bool> verifyPIN(String userId, String pin) async {
    // Hash the pin for verification
    var bytes = utf8.encode(pin); // data being hashed
    var hashedPIN = sha256.convert(bytes).toString();

    // Retrieve the hashed pin using the userId
    String? storedHashedPIN = await secureStorage.read(key: '${userId}_PIN');

    // Return true if the hashed pin matches the stored hashed pin
    return storedHashedPIN == hashedPIN;
  }

  Future<void> deletePIN(String userId) async {
    // Delete the pin for the user
    await secureStorage.delete(key: '${userId}_PIN');
  }
}
