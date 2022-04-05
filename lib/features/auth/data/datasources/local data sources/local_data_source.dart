import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
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
    var res = await database.insert(Users.TABLE_NAME,
        {Users.ID: id, Users.EMAIL: email, Users.PASSWORD: password});
    if (res == -1) {
      throw const DatabaseInsertionException();
    }
  }
}
