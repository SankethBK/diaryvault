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
  static const HASH = "hash";
  static const AUTHOR_ID = "author_id";
  static const TAGS = "tags";
}

class NoteDependencies {
  static const TABLE_NAME = "Note_depencies";

  // Columns
  static const NOTE_ID = "note_id";
  static const ASSET_TYPE = "asset_type";
  static const ASSET_PATH = "asset_path";
}

class Tags {
  static const TABLE_NAME = "tags";

  // Columns
  static const NOTE_ID = "note_id";
  static const NAME = "name";
}

class SmartFolders {
  static const TABLE_NAME = "Smart_folders";

  // Columns
  static const FOLDER_ID = "folder_id";
  static const FOLDER_NAME = "folder_name";
  static const FOLDER_TAGS = "folder_tags";
  static const CREATED_AT = "created_at";
}