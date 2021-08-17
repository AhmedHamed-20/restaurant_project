import 'package:shared_preferences/shared_preferences.dart';

class CachFunc {
  static SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putStringDate({String key, String data}) async {
    return await sharedPreferences.setString(key, data);
  }

  static dynamic getData(String key) {
    return sharedPreferences.get(key);
  }
}
