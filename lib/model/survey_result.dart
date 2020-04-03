import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/model/answer.dart';
import 'package:initsurvey/model/survey.dart';

class SurveyResult {
  String fullName;
  int gender;
  String language;
  String address;
  String ward;
  String district;
  String city;
  String feedback;
  String phoneNumber;
  List<QuestionResult> questions;

  SurveyResult(
      {this.fullName,
      this.gender,
      this.language,
      this.address,
      this.ward,
      this.district,
      this.city,
      this.feedback,
      this.phoneNumber,
      this.questions});

  SurveyResult.fromJson(Map<String, dynamic> json) {
    fullName = json['fullname'];
    gender = json['gender'];
    language = json['language'];
    address = json['address'];
    ward = json['ward'];
    district = json['district'];
    city = json['city'];
    feedback = json['feedback'];
    phoneNumber = json['phoneNumber'];
    if (json['questions'] != null) {
      questions = List<QuestionResult>();
      json['questions'].forEach((v) {
        questions.add(QuestionResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstname'] = this.fullName;
    data['gender'] = this.gender;
    data['language'] = this.language ?? 'vi';
    data['address'] = this.address;
    data['ward'] = this.ward;
    data['district'] = this.district;
    data['city'] = this.city;
    data['feedback'] = this.feedback;
    data['phoneNumber'] = this.phoneNumber;
    if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionResult {
  String question;
  int id;
  String type;
  List<Answer> answers;

  Answer get answer {
    if (Utility.isNullOrEmpty(answers)) {
      answers = [Answer()];
    }
    return answers[0];
  }

  set answer(Answer answer) {
    answers = [answer];
  }

  QuestionResult({
    this.id,
    this.question,
    this.type,
  }) : this.answers = [];

  QuestionResult.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    id = json['id'];
    if (json['answers'] != null) {
      answers = List<Answer>();
      json['answers'].forEach((v) {
        answers.add(Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answers'] = getAnswerText();
    return data;
  }

  bool enableButton() {
    if (type == QuestionType.shortAnswer) {
      return true;
    }
    return Utility.isNullOrEmpty(answers) == false || answers != null;
  }

  bool validate() {
    switch (type) {
      case QuestionType.singleChoice:
      case QuestionType.shortAnswer:
        return Utility.isNullOrEmpty(answer.option) == false;
      case QuestionType.multipleChoice:
        return Utility.isNullOrEmpty(answers) == false;
      case QuestionType.linearScale:
        {
          final int result = int.tryParse(answer.result);
          return result != null;
        }
      case QuestionType.linearScaleGrid:
        {
          for (final item in answers) {
            final int result = int.tryParse(item.result??'');
            if (result == null) {
              return false;
            }
          }
          return true;
        }
      default:
        return Utility.isNullOrEmpty(answers) == false;
        break;
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
        final _option = item?.option;
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
        final _option = item?.option;
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
