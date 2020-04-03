import 'package:flutter/material.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/locale/app_translations.dart';
import 'package:initsurvey/model/survey.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/repository/question_repository.dart';
import 'package:initsurvey/ui/utility/app_snackbar.dart';

class SurveyProvider extends ChangeNotifier {
  SurveyProvider();

  void onReset() {
    indexQuestion = 0;
    results = SurveyResult()..questions = [];
    pageController = PageController(initialPage: 0);
    for (var i = 0; i < data.length; i++) {
      final _question = data[i];
      results.questions.add(
        QuestionResult(
            id: _question.id,
            question: _question.title.en,
            type: _question.type),
      );
    }
  }

  SurveyResult results;
  List<Question> data;

  QuestionResult resultByIndex(int index) {
    return results.questions[index];
  }

  Question get currentQuestion => data[indexQuestion];

  bool get hasData => Utility.isNullOrEmpty(data) == false;

  Future loadQuestionData() async {
    data = await QuestionRepository.loadQuestionFormFile();
  }

  PageController pageController = PageController(initialPage: 0);
  int indexQuestion;

  void pingNotify() {
    notifyListeners();
  }

  void finishQuestion(BuildContext context) {
    if (resultByIndex(indexQuestion).validate()) {
      nextQuestion(context);
    } else {
      Scaffold.of(context).showSnackBar(mySnackBar(
          AppTranslations.of(context).text("question_not_answered")));
    }
  }

  void nextQuestion(BuildContext context) {
    indexQuestion++;
    if (indexQuestion >= data.length) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/contact', ModalRoute.withName('/home'));
    } else {
      pageController.nextPage(
          duration: const Duration(milliseconds: 550), curve: Curves.ease);
      notifyListeners();
    }
  }

  void previousQuestion(BuildContext context) {
    indexQuestion--;
    if (indexQuestion < 0) {
      Navigator.popUntil(context, ModalRoute.withName('/home'));
    } else {
      pageController.previousPage(
          duration: const Duration(milliseconds: 550), curve: Curves.ease);
      notifyListeners();
    }
  }
}
