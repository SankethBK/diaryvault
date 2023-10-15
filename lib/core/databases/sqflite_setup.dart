import 'package:dairy_app/core/constants/exports.dart';
import 'package:path/path.dart';

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
          log.i("Inserting welcome note");
          //as soon as the tables are created, insert a welcome note

          String body =
              """[{"insert":"Welcome to DiaryVault!\\n\\nKey Features:\\n\\n-Rich text editor with support for images and videos.\\n\\n-Your data is securely preserved on your Google Drive / Dropbox account, ensuring complete ownership and privacy\\r.\\n\\n-Sync data between multiple devices.\\r\\n\\n-Fingerprint login on supported devices.\\r\\n\\n-Multiple Themes.\\n\\n\\nHappy notemaking!\\nThe DiaryVault team.\\n\\n"}]""";

          Map<String, Object> notemap = {
            Notes.ID: "f773a170-6447-11ee-9a76-c314b6be99a3",
            Notes.CREATED_AT: DateTime.now().millisecondsSinceEpoch,
            Notes.TITLE: "Welcome to DiaryVault",
            Notes.BODY: body,
            Notes.HASH: "welcome_note_hash",
            Notes.LAST_MODIFIED: DateTime.now().millisecondsSinceEpoch,
            Notes.PLAIN_TEXT: "Read me to get started!",
            Notes.DELETED: 0,
            Notes.AUTHOR_ID: "guest_user_id",
          };
          await db.insert(Notes.TABLE_NAME, notemap);

          log.i("All create queries executed successfully");
          log.i("Welcome Note inserted into table: ${Notes.TABLE_NAME}");
          //   print note
          await db.query(Notes.TABLE_NAME).then((value) => log.i(value));
        } catch (e) {
          log.e(e);
          rethrow;
        }
      },
    );
  }
}
