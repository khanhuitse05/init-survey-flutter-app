import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/model/answer.dart';
import 'package:initsurvey/model/survey.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/view/survey/question/option/option_scale_ui.dart';

class QuestionLinearScaleGrid extends StatefulWidget {
  const QuestionLinearScaleGrid({this.index, this.question, this.result});

  final int index;
  final Question question;
  final QuestionResult result;

  @override
  _QuestionLinearScaleGridState createState() =>
      _QuestionLinearScaleGridState();
}

class _QuestionLinearScaleGridState extends State<QuestionLinearScaleGrid> {
  @override
  void initState() {
    super.initState();
    if (Utility.isNullOrEmpty(widget.result.answers)) {
      widget.result.answers = [];
      for (int i = 0; i < widget.question.option.length; i++) {
        widget.result.answers
            .add(Answer(option: widget.question.option[i].title.en));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < widget.question.option.length; i++)
          _buildRow(i, widget.question.option[i])
      ],
    );
  }

  Widget _buildRow(int indexOption, Option option) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 16),
          child: Text(
            "${indexOption + 1}. ${option.title.text}",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<int>.generate(5, (index) => index)
              .map((i) => _buildIndex(indexOption, i))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildIndex(int indexOption, int index) {
    final int result =
        int.tryParse(widget.result.answers[indexOption].result ?? '');
    final bool isChoice = result == index;
    return OptionScaleUI(
      index,
      onPressed: () {
        if (isChoice == false) {
          setState(() {
            widget.result.answers[indexOption].result = index.toString();
          });
        }
      },
      isChoice: isChoice,
    );
  }
}
