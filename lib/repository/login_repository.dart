import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:initsurvey/core/constans.dart';
import 'package:initsurvey/repository/app_repository.dart';
import 'package:http/http.dart' as http;

///
class LoginRepository {
  // todo Update API later
  static Future<Map> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return {'status': 'success', 'message': ""};

    final Map data = {'username': username, 'password': password};
    final String url = '${kDomainApi}login';
    try {
      final response =
          await http.post(url, body: data).timeout(const Duration(seconds: 10));
      debugPrint(response.body);
      final message = json.decode(response.body);

      if (AppRepository.isSuccess(response.body)) {
        return {'status': 'success', 'message': message['data']};
      } else {
        return {'status': 'error', 'message': message['message']};
      }
    } catch (e) {
      debugPrint("Login fail $e");
    }
    return {'status': 'error', 'message': 'Login fail'};
  }
}
