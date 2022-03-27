import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:dairy_app/core/errors/database_exceptions.dart';
import 'package:dairy_app/features/auth/data/datasources/local%20data%20sources/local_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource implements ILocalDataSource {
  late Database database;

  LocalDataSource() {
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
}
