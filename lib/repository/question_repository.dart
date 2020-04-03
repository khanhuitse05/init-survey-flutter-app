import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:initsurvey/core/cconfig.dart';
import 'package:http/http.dart' as http;
import 'package:initsurvey/core/constans.dart';
import 'package:initsurvey/model/survey.dart';

class QuestionRepository {

  // todo: Update API later
  static Future loadQuestionData() async {
    final url = '${kDomainApi}homemart-questions';
    try {
      final header = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${Config.instance.token}"
      };

      final response = await http
          .get(url, headers: header)
          .timeout(const Duration(seconds: 10));

      debugPrint(response.body);
      if (response.statusCode == HttpStatus.ok) {
        final message = json.decode(response.body);
        final data = [];
        message.forEach(
          (v) {
            data.add(Question.fromJson(v));
          },
        );
        return data;
      }
    } catch (e) {
      debugPrint('Load question fail: $e');
    }
    return null;
  }

  static Future<List<Question>> loadQuestionFormFile() async {
    const String fileName = "assets/datas/data.json";
    final String jsonContent = await rootBundle.loadString(fileName);
    final message = json.decode(jsonContent);

    final List<Question> data = [];
    message.forEach(
      (v) {
        data.add(Question.fromJson(v));
      },
    );
    return data;
  }
}
