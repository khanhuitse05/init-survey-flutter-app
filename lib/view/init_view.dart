import 'package:flutter/material.dart';
import 'package:initsurvey/core/cconfig.dart';
import 'package:initsurvey/core/utility.dart';
import 'package:initsurvey/model/user.dart';
import 'package:initsurvey/repository/survey/survey_provider.dart';
import 'package:initsurvey/ui/utility/indicator.dart';
import 'package:initsurvey/ui/utility/pattern.dart';
import 'package:provider/provider.dart';

class InitView extends StatefulWidget {
  @override
  _InitViewState createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PatternTopRight(),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/ui/bottom.png",
              fit: BoxFit.fill,
            ),
          ),
          const Center(
            child: Indicator(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    onLogin();
  }

  Future onLogin() async {
    final User user = await Config.instance.loadUser();
    final String token = await Config.instance.loadToken();

    if (user != null && Utility.isNullOrEmpty(token) == false) {
      final SurveyProvider survey =
          Provider.of<SurveyProvider>(context, listen: false);
      await survey.loadQuestionData();
      if (survey.hasData) {
        // go to home page
        await Navigator.pushReplacementNamed(context, '/home');
      } else {
        await Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      await Navigator.pushReplacementNamed(context, '/login');
    }
  }
}
