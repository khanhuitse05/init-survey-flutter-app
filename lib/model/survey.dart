import 'package:initsurvey/model/localize.dart';

class Question {
  int id;
  String type;
  Localize? title;
  List<Option> option;

  Question({
    required this.id,
    required this.type,
    this.title,
    this.option = const [],
  });

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        title =
            json['title'] != null ? Localize.fromJson(json['title']) : null,
        option = json['option'] != null
            ? (json['option'] as List)
                .map((v) => Option.fromJson(v as Map<String, dynamic>))
                .toList()
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title?.toJson();
    data['option'] = option.map((v) => v.toJson()).toList();
    return data;
  }
}

class Option {
  Localize? title;
  bool otherSpecify;

  Option({this.otherSpecify = false, this.title});

  Option.fromJson(Map<String, dynamic> json)
      : title =
            json['title'] != null ? Localize.fromJson(json['title']) : null,
        otherSpecify = json['otherSpecify'] ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title?.toJson();
    data['otherSpecify'] = otherSpecify;
    return data;
  }
}

class QuestionType {
  static const String shortAnswer = 'shortAnswer';
  static const String singleChoice = 'singleChoice';
  static const String multipleChoice = 'multipleChoice';
  static const String linearScale = 'linearScale';
  static const String linearScaleGrid = 'linearScaleGrid';
}
