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

  // Encryption columns (all key material lives at note level so it travels
  // with cloud sync; there is no separate metadata file)
  static const IS_ENCRYPTED = "is_encrypted";
  static const ENCRYPTION_VERSION = "encryption_version";

  /// base64 KDF salt of the keychain that wrapped this note's keys
  static const ENC_SALT = "enc_salt";

  /// Master key wrapped with passphrase-derived KEK (constant per keychain,
  /// replicated on every encrypted note)
  static const ENC_WRAPPED_MK_PASS = "enc_wrapped_mk_pass";

  /// Master key wrapped with recovery-code-derived KEK (constant per keychain)
  static const ENC_WRAPPED_MK_RECOVERY = "enc_wrapped_mk_recovery";

  /// This note's DEK wrapped with the master key
  static const WRAPPED_DEK = "wrapped_dek";
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
