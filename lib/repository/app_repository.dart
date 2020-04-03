import 'dart:convert';
import 'dart:core';

class AppRepository{

  static bool isSuccess(String body) {
    try {
      var message = json.decode(body);
      return message['status'] == 'success';
    } catch (e) {
      return false;
    }
  }

  static String getMessage(String body) {
    try {
      var message = json.decode(body);
      return message['message'];
    } catch (e) {
      return '';
    }
  }
}