import 'package:flutter/material.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/model/answer.dart';
import 'package:initsurvey/model/survey.dart';
import 'package:initsurvey/model/survey_result.dart';
import 'package:initsurvey/view/survey/question/option/option_choice_ui.dart';
import 'package:initsurvey/view/survey/question/option/option_input_ui.dart';

class QuestionMultipleChoice extends StatefulWidget {
  const QuestionMultipleChoice({this.index, this.question, this.result});

  final int index;
  final Question question;
  final QuestionResult result;

  @override
  _QuestionMultipleChoiceState createState() => _QuestionMultipleChoiceState();
}

class _QuestionMultipleChoiceState extends State<QuestionMultipleChoice> {
  @override
  Widget build(BuildContext context) {
    final Question question = widget.question;

    return Column(children: [
      for (int i = 0; i < question.option.length; i++)
        _buildOption(i, question.option[i])
    ]);
  }

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: "");
    if (Utility.isNullOrEmpty(widget.result.answers)) {
      for (int i = 0; i < widget.question.option.length; i++) {
        widget.result.answers.add(
            Answer(result: "", option: widget.question.option[i].title.en));
      }
    } else {
      for (int i = 0; i < widget.question.option.length; i++) {
        if (widget.question.option[i].otherSpecify) {
          controller =
              TextEditingController(text: widget.result.answers[i].result);
        }
      }
    }
  }

  Widget _buildOption(int index, Option option) {
    final QuestionResult result = widget.result;
    final bool isChoose =
        Utility.isNullOrEmpty(result.answers[index].result) == false;

    if (option.otherSpecify) {
      controller.text = result.answers[index].result;
      if (isChoose) {
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
      return OptionInputUI(
        isChoose: isChoose,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              labelText: option.title.text, border: InputBorder.none),
          onChanged: (value) {
            if (result.answers[index].result.isEmpty != value.isEmpty) {
              setState(() {
                result.answers[index].result = value;
              });
            } else {
              result.answers[index].result = value;
            }
          },
        ),
      );
    } else {
      return OptionChoiceUI(
        title: option.title.text,
        isChoose: isChoose,
        onPressed: () {
          FocusScope.of(context).unfocus();
          setState(() {
            if (isChoose) {
              result.answers[index].result = "";
            } else {
              result.answers[index].result = "choose";
            }
          });
        },
      );
    }
  }
}
