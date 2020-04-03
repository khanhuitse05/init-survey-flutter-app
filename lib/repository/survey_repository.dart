import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:initsurvey/core/cconfig.dart';
import 'package:initsurvey/core/constans.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/repository/app_repository.dart';
import 'package:http/http.dart' as http;

///
class SurveyRepository {
  static Future<Map> sent(SurveyResult survey) async {

    await Future.delayed(const Duration(seconds: 1));
    return {'status': 'success'};

    // todo: Update api later
    final String url = '${kDomainApi}save-homemart-survey';
    debugPrint(const JsonEncoder.withIndent(" ").convert(survey),
        wrapWidth: 1024);
    try {
      final header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Config.instance.token}"
      };
      final response = await http
          .post(url,
              headers: header, body: json.encode(survey.toJson()).toString())
          .timeout(const Duration(seconds: 10));

      debugPrint(response.body);
      if (response.statusCode == 200) {
        final message = json.decode(response.body);
        if (AppRepository.isSuccess(response.body)) {
          return {
            'status': 'success',
            'message': message['message'],
          };
        } else {
          return {
            'status': 'error',
            'message': message['message'],
          };
        }
      }
    } catch (e) {
      debugPrint('Save data fail: $e');
    }
    return {'status': 'error', 'message': 'something_wrong'};
  }
}
