import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/model/answer.dart';
import 'package:initsurvey/model/survey.dart';

class SurveyResult {
  String? fullName;
  int? gender;
  String? language;
  String? address;
  String? ward;
  String? district;
  String? city;
  String? feedback;
  String? phoneNumber;
  List<QuestionResult> questions;

  SurveyResult({
    this.fullName,
    this.gender,
    this.language,
    this.address,
    this.ward,
    this.district,
    this.city,
    this.feedback,
    this.phoneNumber,
    this.questions = const [],
  });

  SurveyResult.fromJson(Map<String, dynamic> json)
      : fullName = json['fullname'],
        gender = json['gender'],
        language = json['language'],
        address = json['address'],
        ward = json['ward'],
        district = json['district'],
        city = json['city'],
        feedback = json['feedback'],
        phoneNumber = json['phoneNumber'],
        questions = json['questions'] != null
            ? (json['questions'] as List)
                .map((v) => QuestionResult.fromJson(v as Map<String, dynamic>))
                .toList()
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = fullName;
    data['gender'] = gender;
    data['language'] = language ?? 'vi';
    data['address'] = address;
    data['ward'] = ward;
    data['district'] = district;
    data['city'] = city;
    data['feedback'] = feedback;
    data['phoneNumber'] = phoneNumber;
    if (questions.isNotEmpty) {
      data['questions'] = questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionResult {
  String? question;
  int? id;
  String? type;
  List<Answer> answers;

  Answer get answer {
    if (Utility.isNullOrEmpty(answers)) {
      answers = [Answer()];
    }
    return answers.first;
  }

  set answer(Answer answer) {
    answers = [answer];
  }

  QuestionResult({
    this.id,
    this.question,
    this.type,
    this.answers = const [],
  });

  QuestionResult.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        id = json['id'],
        type = json['type'],
        answers = json['answers'] != null
            ? (json['answers'] as List)
                .map((v) => Answer.fromJson(v as Map<String, dynamic>))
                .toList()
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answers'] = getAnswerText();
    return data;
  }

  bool enableButton() {
    if (type == QuestionType.shortAnswer) {
      return true;
    }
    return Utility.isNullOrEmpty(answers) == false;
  }

  bool validate() {
    switch (type) {
      case QuestionType.singleChoice:
      case QuestionType.shortAnswer:
        return Utility.isNullOrEmpty(answer.option) == false;
      case QuestionType.multipleChoice:
        return Utility.isNullOrEmpty(answers) == false;
      case QuestionType.linearScale:
        final int? result = int.tryParse(answer.result);
        return result != null;
      case QuestionType.linearScaleGrid:
        for (final item in answers) {
          final int? result = int.tryParse(item.result);
          if (result == null) {
            return false;
          }
        }
        return true;
      default:
        return Utility.isNullOrEmpty(answers) == false;
    }
  }

  String getAnswerText() {
    switch (type) {
      case QuestionType.singleChoice:
      case QuestionType.shortAnswer:
      case QuestionType.multipleChoice:
        return getAnswerTextMultiSelected();
      case QuestionType.linearScaleGrid:
        return getAnswerTextScaleGrid();
      default:
        return answer.option;
    }
  }

  String getAnswerTextScaleGrid() {
    String value = '';
    if (Utility.isNullOrEmpty(answers) == false) {
      for (final item in answers) {
        final _option = item.option;
        if (Utility.isNullOrEmpty(_option) == false) {
          if (Utility.isNullOrEmpty(value)) {
            value = _option;
          } else {
            value += ' / $_option';
          }
        }
      }
    }
    return value;
  }

  String getAnswerTextMultiSelected() {
    String value = '';
    if (Utility.isNullOrEmpty(answers) == false) {
      for (final item in answers) {
        final _option = item.option;
        if (Utility.isNullOrEmpty(_option) == false) {
          if (Utility.isNullOrEmpty(value)) {
            value = _option;
          } else {
            value += ' / $_option';
          }
        }
      }
    }
    return value;
  }

  String getAnswerTextMultiSelectedWithTypeAnswer() {
    String value = '';
    if (Utility.isNullOrEmpty(answers) == false) {
      for (final item in answers) {
        if (Utility.isNullOrEmpty(item.result) == false) {
          if (Utility.isNullOrEmpty(value)) {
            value = '${item.option} -> ${item.result}';
          } else {
            value += ' / ${item.option} -> ${item.result}';
          }
        }
      }
    }
    return value;
  }
}
