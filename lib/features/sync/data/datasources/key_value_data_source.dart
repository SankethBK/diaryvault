import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/sync/core/exports.dart';

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
