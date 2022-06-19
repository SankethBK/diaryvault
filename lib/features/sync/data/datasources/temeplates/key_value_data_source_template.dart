abstract class IKeyValueDataSource {
  String? getValue(String key);

  Future<void> setValue(String key, String value);
}
