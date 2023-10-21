import 'dart:io';
import 'package:dairy_app/core/databases/db_schemas.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'welcome_note.dart';

final log = printer("SQLTableSetup");

class DBProvider {
  DBProvider._();
  static final DBProvider instance = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "prod.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        try {
          await db.execute(
            """
          CREATE TABLE ${Users.TABLE_NAME} (
            ${Users.ID} TEXT PRIMARY KEY,
            ${Users.EMAIL} TEXT,
            ${Users.PASSWORD} TEXT
          )
          """,
          );

          await db.execute("""
          CREATE TABLE ${Notes.TABLE_NAME} (
            ${Notes.ID} TEXT, 
            ${Notes.CREATED_AT} DATETIME,
            ${Notes.TITLE} TEXT,
            ${Notes.BODY} TEXT, 
            ${Notes.HASH} TEXT,
            ${Notes.LAST_MODIFIED} DATETIME, 
            ${Notes.PLAIN_TEXT} TEXT, 
            ${Notes.DELETED} INTEGER, 
            ${Notes.AUTHOR_ID} TEXT
          )
          """);

          await db.execute("""
            CREATE TABLE ${NoteDependencies.TABLE_NAME} (
              ${NoteDependencies.NOTE_ID} TEXT,
              ${NoteDependencies.ASSET_TYPE} TEXT, 
              ${NoteDependencies.ASSET_PATH} TEXT
            )
            """);
          log.i(" All create queries executed successfully");
          log.i("Inserting welcome note");

          // As soon as the tables are created, insert a welcome note
          // Check if there are no records in the notes table before inserting the initial data
          final count = Sqflite.firstIntValue(
              await db.rawQuery('SELECT COUNT(*) FROM ${Notes.TABLE_NAME}'));
          if (count == 0) {
            await db.insert(Notes.TABLE_NAME, welcomeNote);
          }
          log.i("Welcome Note inserted into table: ${Notes.TABLE_NAME} test");
        } catch (e) {
          log.e(e);
          rethrow;
        }
      },
    );
  }
}
