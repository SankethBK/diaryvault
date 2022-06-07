abstract class IOAuthKeyDataSource {
  Future<String?> getOAuthKey(String key);

  Future<void> setOAuthKey(String key, String value);
}
