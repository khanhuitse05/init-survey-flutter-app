import 'package:flutter/material.dart';
import 'package:initsurvey/model/answer.dart';
import 'package:initsurvey/model/survey.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/view/survey/question/option/option_choice_ui.dart';
import 'package:initsurvey/view/survey/question/option/option_input_ui.dart';

class QuestionSingleChoice extends StatefulWidget {
  const QuestionSingleChoice({this.index, this.question, this.result});

  final int index;
  final Question question;
  final QuestionResult result;

  @override
  _QuestionSingleChoiceState createState() => _QuestionSingleChoiceState();
}

class _QuestionSingleChoiceState extends State<QuestionSingleChoice> {
  @override
  Widget build(BuildContext context) {
    final question = widget.question;

    return Column(
      children: question.option.map(_buildOption).toList(),
    );
  }

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "");
  }

  Widget _buildOption(Option option) {
    final result = widget.result;
    final bool isChoose = option.title.en == result.answer.option;

    if (option.otherSpecify) {
      if (isChoose) {
        controller.text = result.answer.result;
      } else {
        controller.text = '';
      }

      return OptionInputUI(
        isChoose: isChoose,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: option.title.text, border: InputBorder.none),
          onChanged: (value) {
            result.answer.result = value;
          },
          onTap: () {
            if (isChoose == false) {
              result.answer = Answer(option: option.title.en, result: "");
            }
          },
        ),
      );
    } else {
      return OptionChoiceUI(
        title: option.title.text,
        isChoose: isChoose,
        onPressed: isChoose
            ? null
            : () {
                FocusScope.of(context).unfocus();
                setState(() {
                  result.answer =
                      Answer(option: option.title.en, result: 'choose');
                });
              },
      );
    }
  }
}
