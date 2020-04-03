import 'package:flutter/material.dart';
import 'package:initsurvey/locale/app_translations.dart';
import 'package:initsurvey/repository/survey/survey_provider.dart';
import 'package:initsurvey/ui/button/icon_button_home.dart';
import 'package:initsurvey/ui/survey/survey_process.dart';
import 'package:initsurvey/ui/utility/pattern.dart';
import 'package:initsurvey/ui/utility/ui_utility.dart';
import 'package:initsurvey/view/survey/question_ui.dart';
import 'package:provider/provider.dart';

class SurveyView extends StatefulWidget {
  @override
  _SurveyViewState createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  @override
  Widget build(BuildContext context) {
    final SurveyProvider provider = Provider.of(context);
    return WillPopScope(
      onWillPop: () async {
        provider.previousQuestion(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              PatternTopRight(),
              PatternBottomLeft(),
              PatternBottomRight(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 64,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: IconTheme(
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(arrowBack),
                              onPressed: () {
                                provider.previousQuestion(context);
                              }),
                          Expanded(
                            child: SurveyProcess(provider.indexQuestion + 1,
                                provider.data.length),
                          ),
                          const IconButtonHome(
                            icon: Icons.home,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      itemCount: provider.data.length,
                      controller: provider.pageController,
                      itemBuilder: (_, index) {
                        return QuestionUI(
                          index,
                          key: Key(index.toString()),
                        );
                      },
                    ),
                  ),
                  _ButtonSubmit(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightGreen,
          boxShadow: [
            BoxShadow(
              color: Colors.green[700],
              blurRadius: 0,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            )
          ]),
      child: FlatButton(
        child: Text(
          AppTranslations.of(context).text('next').toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          FocusScope.of(context).unfocus();
          Provider.of<SurveyProvider>(context, listen: false)
              .finishQuestion(context);
        },
      ),
    );
  }
}
