import 'package:dairy_app/core/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'temeplates/key_value_data_source_template.dart';

final log = printer("KeyValueDataSource");

class KeyValueDataSource implements IKeyValueDataSource {
  static late SharedPreferences prefs;

  KeyValueDataSource._();

  static create() async {
    prefs = await SharedPreferences.getInstance();
    return KeyValueDataSource._();
  }

  @override
  String? getValue(String key) {
    log.i("searching for key $key");
    return prefs.getString(key);
  }

  @override
  Future<void> setValue(String key, String value) async {
    log.i("setting the value $value for $key");
    await prefs.setString(key, value);
  }
}
