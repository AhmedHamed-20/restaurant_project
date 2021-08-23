import 'package:shared_preferences/shared_preferences.dart';

class CachFunc {
  static SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putStringDate({String key, String data}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key, data);
  }

  static String getData(String key) {
    return sharedPreferences.getString(key);
  }

  static Future<bool> deleteData(String key) async {
    return await sharedPreferences.remove(key);
  }
}
