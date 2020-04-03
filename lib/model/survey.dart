import 'package:initsurvey/model/localize.dart';

class Question {
  int id;
  String type;
  Localize title;
  List<Option> option;

  Question({this.id, this.type, this.title, this.option});

  Question.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    type = json['type'];
    title = json['title'] != null ? Localize.fromJson(json['title']) : null;
    if (json['option'] != null) {
      option = List<Option>();
      json['option'].forEach((v) {
        option.add(Option.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.option != null) {
      data['option'] = this.option.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Option {
  Localize title;
  bool otherSpecify;

  Option({this.otherSpecify, this.title});

  Option.fromJson(Map<String, dynamic> json) {
    title = Localize.fromJson(json['title']);
    otherSpecify = json['otherSpecify'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['otherSpecify'] = this.otherSpecify;
    return data;
  }
}

class QuestionType {
  static const String shortAnswer = "shortAnswer";
  static const String singleChoice = "singleChoice";
  static const String multipleChoice = "multipleChoice";
  static const String linearScale = "linearScale";
  static const String linearScaleGrid = "linearScaleGrid";
}
