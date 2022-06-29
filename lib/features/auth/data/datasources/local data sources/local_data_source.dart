import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dairy_app/core/databases/db_schemas.dart';

final log = printer("AuthLocalDataSource");

class AuthLocalDataSource implements IAuthLocalDataSource {
  late Database database;

  AuthLocalDataSource() {
    DBProvider.instance.database.then((db) {
      database = db;
    });
  }

  @override
  Future<LoggedInUserModel> signUpUser(
      {required id, required String email, required String password}) async {
    var res = await database.insert(Users.TABLE_NAME,
        {Users.ID: id, Users.EMAIL: email, Users.PASSWORD: password});
    if (res != -1) {
      return LoggedInUserModel(email: email, id: id);
    }
    log.e("sign up failed because insertion failed in local db");
    throw const DatabaseInsertionException();
  }

  @override
  Future<LoggedInUserModel> signInUser(
      {required String email, required String password}) async {
    List<Map<String, Object?>> result;
    try {
      result = await database.query(
        Users.TABLE_NAME,
        columns: [Users.ID, Users.EMAIL, Users.PASSWORD],
        where: "${Users.EMAIL} = ?",
        whereArgs: [email],
      );
    } catch (e) {
      log.e("Local database query failed $e");
      throw const DatabaseQueryException();
    }

    log.d("result of sign in user query $result");

    if (result.isEmpty) {
      throw SignInFailure.emailDoesNotExists();
    }

    if (result[0][Users.PASSWORD] != password) {
      throw SignInFailure.wrongPassword();
    }

    return LoggedInUserModel.fromJson({
      "id": result[0][Users.ID] as String,
      "email": result[0][Users.EMAIL] as String
    });
  }

  @override
  Future<void> cacheUser(
      {required id, required String email, required String password}) async {
    log.i("Caching the new user $email, $password");
    // If we already have an entry with that email just change the password
    var result = await database.query(
      Users.TABLE_NAME,
      columns: [Users.ID, Users.EMAIL, Users.PASSWORD],
      where: "${Users.EMAIL} = ?",
      whereArgs: [email],
    );

    if (result.isEmpty) {
      log.i("Inserting a new record");
      var res = await database.insert(Users.TABLE_NAME,
          {Users.ID: id, Users.EMAIL: email, Users.PASSWORD: password});
      if (res == -1) {
        log.e("Could not insert new record");
        throw const DatabaseInsertionException();
      }
      return;
    } else {
      log.i("Updating the existing record");
      var count = await database.update(
        Users.TABLE_NAME,
        {...result[0], "password": password},
        where: "${Users.EMAIL} = ?",
        whereArgs: [email],
      );

      if (count != 1) {
        log.e("Failed to update entry");
        throw const DatabaseUpdateException();
      }
    }
  }

  @override
  Future<bool> verifyPassword(String userId, String password) async {
    var result = await database.query(
      Users.TABLE_NAME,
      columns: [Users.ID, Users.EMAIL, Users.PASSWORD],
      where: "${Users.ID} = ? AND ${Users.PASSWORD} = ?",
      whereArgs: [userId, password],
    );

    return result.isNotEmpty;
  }

  @override
  Future<void> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    // 1. Retrieve the record
    var result = await database.query(
      Users.TABLE_NAME,
      columns: [Users.ID, Users.EMAIL, Users.PASSWORD],
      where: "${Users.EMAIL} = ?",
      whereArgs: [email],
    );

    if (result.isEmpty) {
      throw const DatabaseQueryException();
    }

    var count = await database.update(
      Users.TABLE_NAME,
      {...result[0], "password": newPassword},
      where: "${Users.EMAIL} = ? AND ${Users.PASSWORD} = ?",
      whereArgs: [email, oldPassword],
    );

    if (count != 1) {
      throw const DatabaseUpdateException();
    }
  }

  @override
  Future<LoggedInUserModel> signInDirectly({required String userId}) async {
    List<Map<String, Object?>> result;
    log.i("Starting passwordless sign in");

    try {
      result = await database.query(
        Users.TABLE_NAME,
        columns: [Users.ID, Users.EMAIL],
        where: "${Users.ID} = ?",
        whereArgs: [userId],
      );

      return LoggedInUserModel.fromJson({
        "id": result[0][Users.ID] as String,
        "email": result[0][Users.EMAIL] as String
      });
    } catch (e) {
      log.e("Local database query failed $e");
      throw const DatabaseQueryException();
    }
  }

  @override
  Future<void> updateEmail({
    required String oldEmail,
    required String password,
    required String newEmail,
  }) async {
    // 1. Retrieve the record
    var result = await database.query(
      Users.TABLE_NAME,
      columns: [Users.ID, Users.EMAIL, Users.PASSWORD],
      where: "${Users.EMAIL} = ?",
      whereArgs: [oldEmail],
    );

    if (result.isEmpty) {
      throw const DatabaseQueryException();
    }

    var count = await database.update(
      Users.TABLE_NAME,
      {...result[0], "email": newEmail},
      where: "${Users.EMAIL} = ? AND ${Users.PASSWORD} = ?",
      whereArgs: [oldEmail, password],
    );

    if (count != 1) {
      throw const DatabaseUpdateException();
    }
  }
}
