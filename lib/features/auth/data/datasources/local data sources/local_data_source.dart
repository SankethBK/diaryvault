import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dairy_app/core/databases/db_schemas.dart';

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
    var res = await database
        .insert("Users", {"id": id, "email": email, "password": password});
    if (res == 1) {
      return LoggedInUserModel(email: email, id: id);
    }
    throw const DatabaseInsertionException();
  }

  @override
  Future<LoggedInUserModel> signInUser(
      {required String email, required String password}) async {
    try {
      var result = await database.query(
        Users.TABLE_NAME,
        columns: [Users.ID, Users.EMAIL],
        where: "${Users.EMAIL} = ?",
        whereArgs: [email],
      );

      if (result.isEmpty) {
        throw SignInFailure.emailDoesNotExists();
      }

      if (result[0][Users.PASSWORD] != password) {
        throw SignInFailure.wrongPassword();
      }

      return LoggedInUserModel.fromJson(result[0] as Map<String, String>);
    } catch (e) {
      throw const DatabaseQueryException();
    }
  }
}
