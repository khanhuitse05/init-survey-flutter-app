import 'dart:convert';

import 'package:initsurvey/core/storage_manager.dart';
import 'package:initsurvey/model/user.dart';

class Config {
  factory Config() => instance;

  Config._internal();

  static final Config instance = Config._internal();

  User? user;
  String? token;

  Future<User?> loadUser() async {
    final _data = await StorageManager.getObjectByKey('user');
    if (_data != null) {
      final User _user = User.fromJson(json.decode(_data as String));
      user = _user;
    } else {
      user = null;
    }
    return user;
  }

  Future<String?> loadToken() async {
    token = await StorageManager.getObjectByKey('token') as String?;
    return token;
  }

  void saveUser(User? _user) {
    user = _user;
    StorageManager.setObject(
        'user', _user == null ? '' : json.encode(user!.toJson()));
  }

  void saveToken(String _token) {
    token = _token;
    StorageManager.setObject('token', token);
  }
}
