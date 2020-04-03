import 'package:flutter/material.dart';
import 'package:initsurvey/model/answer.dart';
import 'package:initsurvey/model/survey.dart';
import 'package:initsurvey/model/survey_result.dart';

class QuestionShortAnswer extends StatefulWidget {
  const QuestionShortAnswer({this.index, this.question, this.result});

  final int index;
  final Question question;
  final QuestionResult result;

  @override
  _QuestionShortAnswerState createState() => _QuestionShortAnswerState();
}

class _QuestionShortAnswerState extends State<QuestionShortAnswer> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.result.answer.option);

    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        autofocus: true,
        onChanged: (value) {
          widget.result.answer = Answer(option: value, result: 'Type answer');
        },
        onEditingComplete: () {
          setState(() {
            widget.result.answer =
                Answer(option: controller.text, result: 'Type answer');
          });
        },
        onSubmitted: (value) {
          setState(() {
            widget.result.answer =
                Answer(option: controller.text, result: 'Type answer');
          });
        },
        maxLines: 6,
        keyboardType: TextInputType.multiline,
        maxLength: 200,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }
}
