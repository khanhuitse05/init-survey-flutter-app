import 'dart:convert';

import 'package:initsurvey/core/storage_manager.dart';
import 'package:initsurvey/model/user.dart';

class Config {
  factory Config() => instance;

  Config._internal();

  static final Config instance = Config._internal();

  User user;
  String token;

  Future loadUser() async {
    final _data = await StorageManager.getObjectByKey('user');
    if (_data != null) {
      final User _user = User.fromJson(json.decode(_data));
      this.user = _user;
    } else {
      user = null;
    }
    return user;
  }

  Future loadToken() async {
    this.token = await StorageManager.getObjectByKey('token');
    return this.token;
  }

  void saveUser(User _user) {
    this.user = _user;
    StorageManager.setObject(
        'user', _user == null ? '' : json.encode(this.user.toJson()));
  }

  void saveToken(String _token) {
    this.token = _token;
    StorageManager.setObject('token', this.token);
  }
}
