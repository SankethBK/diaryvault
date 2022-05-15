class Users {
  static const String TABLE_NAME = "Users";

  // Columns
  static const ID = "id";
  static const EMAIL = "email";
  static const PASSWORD = "password";
}

class Notes {
  static const TABLE_NAME = "Notes";

  // Columns
  static const ID = "id";
  static const CREATED_AT = "created_at";
  static const TITLE = "title";
  static const BODY = "body";
  static const LAST_MODIFIED = "last_modified";
  static const PLAIN_TEXT = "plain_text";
  static const DELETED = "deleted";
}

class NoteDependencies {
  static const TABLE_NAME = "Note_depencies";

  // Columns
  static const NOTE_ID = "note_id";
  static const ASSET_TYPE = "asset_type";
  static const ASSET_PATH = "asset_path";
}
