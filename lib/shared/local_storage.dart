import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _jwt = "jwt";

  static Future<void> saveJwt(String jwt) async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_jwt, jwt);
    });
  }

  static Future<String?> getJwt() async {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getString(_jwt);
    });
  }

  static Future<bool> cleanStorage() async {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.clear();
    });
  }
}
