import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheService {
  Future<bool> setData({
    required String key,
    required dynamic value,
  });
  dynamic getData({
    required String key,
  });
  Future<bool> removeData(String key);
}

class CacheHelper extends CacheService {
  SharedPreferences sharedPreferences;
  CacheHelper(this.sharedPreferences);
  @override
  Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else {
      return await sharedPreferences.setBool(key, value);
    }
  }

  @override
  dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  @override
  Future<bool> removeData(String key) async {
    return await sharedPreferences.remove(key);
  }
}
