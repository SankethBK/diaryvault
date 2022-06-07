import 'package:shared_preferences/shared_preferences.dart';
import 'temeplates/oauth_key_data_source_template.dart';

class OAuthKeyDataSource implements IOAuthKeyDataSource {
  late SharedPreferences prefs;

  OAuthKeyDataSource() {
    SharedPreferences.getInstance().then((pref) => prefs = pref);
  }

  @override
  Future<String?> getOAuthKey(String key) async {
    prefs.getString(key);
  }

  @override
  Future<void> setOAuthKey(String key, String value) async {
    await prefs.setString(key, value);
  }
}
