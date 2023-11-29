import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';

class PINAuthRepository {
  final storage = new FlutterSecureStorage();

  Future<void> savePIN(String userId, String pin) async {
    // Hash the pin before storing it for security reasons
    var bytes = utf8.encode(pin); // data being hashed
    var hashedPIN = sha256.convert(bytes).toString();

    // Store the hashed pin with the userId as part of the key
    await storage.write(key: '${userId}_PIN', value: hashedPIN);
    print(isPINStored(userId));
  }
  Future<bool> isPINStored(String userId) async {
    String? storedPIN = await storage.read(key: '${userId}_PIN');
    return storedPIN != null;
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