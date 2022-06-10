import 'package:dairy_app/core/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'temeplates/oauth_key_data_source_template.dart';

final log = printer("OAuthKeyDataSource");

class OAuthKeyDataSource implements IOAuthKeyDataSource {
  static late SharedPreferences prefs;

  OAuthKeyDataSource._();

  static create() async {
    prefs = await SharedPreferences.getInstance();
    return OAuthKeyDataSource._();
  }

  @override
  Future<String?> getOAuthKey(String key) async {
    log.i("searching for key $key");
    return prefs.getString(key);
  }

  @override
  Future<void> setOAuthKey(String key, String value) async {
    log.i("setting the value $value for $key");
    await prefs.setString(key, value);
  }
}
