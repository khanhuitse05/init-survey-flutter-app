import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const String storageDomain = 'my_app_storage_key';

  static Future<void> setObject(String keyName, dynamic keyValue) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    switch (keyValue.runtimeType) {
      case String:
        await pref.setString(storageDomain + keyName, keyValue as String);
        break;
      case int:
        await pref.setInt(storageDomain + keyName, keyValue as int);
        break;
      case bool:
        await pref.setBool(storageDomain + keyName, keyValue as bool);
        break;
      case double:
        await pref.setDouble(storageDomain + keyName, keyValue as double);
        break;
      case List:
        await pref.setStringList(
            storageDomain + keyName, keyValue as List<String>);
        break;
    }
  }

  static Future<dynamic> getObjectByKey(String keyName) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(storageDomain + keyName);
  }

  static Future<bool> containsKey(String keyName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(storageDomain + keyName);
  }

  static Future<void> clearAll() async {
    final SharedPreferences preferences =
        await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static Future<void> clearObjectByKey(String keyName) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(storageDomain + keyName);
  }
}
