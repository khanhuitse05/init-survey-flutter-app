import 'package:flutter/material.dart';
import 'package:initsurvey/model/answer.dart';
import 'package:initsurvey/model/survey.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/view/survey/question/option/option_scale_ui.dart';

class QuestionLinearScale extends StatefulWidget {
  const QuestionLinearScale({this.index, this.question, this.result});

  final int index;
  final Question question;
  final QuestionResult result;

  @override
  _QuestionLinearScaleState createState() => _QuestionLinearScaleState();
}

class _QuestionLinearScaleState extends State<QuestionLinearScale> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          List<int>.generate(5, (index) => index).map(_buildIndex).toList(),
    );
  }

  Widget _buildIndex(int index) {
    final int result = int.tryParse(widget.result.answer.result??'');
    return OptionScaleUI(
      index,
      onPressed: () {
        setState(() {
          widget.result.answer = Answer(
              option: widget.question.title.en, result: index.toString());
        });
      },
      isChoice: result == index,
    );
  }
}
