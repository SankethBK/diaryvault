import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';

class PINAuthRepository {
  // ignore: prefer_const_constructors
  final storage = FlutterSecureStorage();
  Future<void> savePIN(String userId, String pin) async {
    var bytes = utf8.encode(pin); // data being hashed
    var hashedPIN = sha256.convert(bytes).toString();
    await storage.write(key: '${userId}_PIN', value: hashedPIN);
  }

  Future<bool> isPINStored(String userId) async {
    String? storedPIN = await storage.read(key: '${userId}_PIN');
    return storedPIN != null;
  }

  Future<bool> verifyPIN(String userId, String pin) async {
    var bytes = utf8.encode(pin); // data being hashed
    var hashedPIN = sha256.convert(bytes).toString();
    String? storedHashedPIN = await storage.read(key: '${userId}_PIN');
    return storedHashedPIN == hashedPIN;
  }

  Future<void> deletePIN(String userId) async {
    await storage.delete(key: '${userId}_PIN');
  }
}