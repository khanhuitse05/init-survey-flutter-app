import 'dart:convert';

class AppRepository {
  static bool isSuccess(String body) {
    try {
      final message = json.decode(body);
      return message['status'] == 'success';
    } catch (e) {
      return false;
    }
  }

  static String getMessage(String body) {
    try {
      final message = json.decode(body);
      return message['message']?.toString() ?? '';
    } catch (e) {
      return '';
    }
  }
}
