import 'package:flutter/material.dart';
import 'package:initsurvey/model/survey.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/repository/survey/survey_provider.dart';
import 'package:initsurvey/view/survey/question/question_linear_scale_grid.dart';
import 'package:initsurvey/view/survey/question/question_multiple_choice.dart';
import 'package:initsurvey/view/survey/question/question_single_choice.dart';
import 'package:initsurvey/view/survey/question/question_linear_scale.dart';
import 'package:initsurvey/view/survey/question/question_short_answer.dart';
import 'package:provider/provider.dart';

class QuestionUI extends StatefulWidget {
  const QuestionUI(this.index, {Key key}) : super(key: key);

  final int index;

  @override
  _QuestionUIState createState() => _QuestionUIState();
}

class _QuestionUIState extends State<QuestionUI> {
  @override
  Widget build(BuildContext context) {
    final SurveyProvider provider = Provider.of(context);
    final Question question = provider.data[widget.index];
    final QuestionResult result = provider.resultByIndex(widget.index);
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
          child: Text(
            '${question.id}. ${question.title.text}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: buildContent(context, widget.index,
              question: question, result: result),
        ),
      ],
    );
  }

  Widget buildContent(BuildContext context, int index,
      {Question question, QuestionResult result}) {
    switch (question.type) {
      case QuestionType.singleChoice:
        return QuestionSingleChoice(
            index: index, question: question, result: result);
        break;
      case QuestionType.multipleChoice:
        return QuestionMultipleChoice(
            index: index, question: question, result: result);
        break;
      case QuestionType.linearScale:
        return QuestionLinearScale(
            index: index, question: question, result: result);
        break;
      case QuestionType.linearScaleGrid:
        return QuestionLinearScaleGrid(
            index: index, question: question, result: result);
        break;
      default:
        return QuestionShortAnswer(
            index: index, question: question, result: result);
        break;
    }
  }
}
