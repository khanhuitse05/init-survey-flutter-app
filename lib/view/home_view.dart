import 'package:flutter/material.dart';
import 'package:initsurvey/core/cconfig.dart';
import 'package:initsurvey/locale/app_translations.dart';
import 'package:initsurvey/locale/language_button.dart';
import 'package:initsurvey/repository/survey/survey_provider.dart';
import 'package:initsurvey/ui/button/gradient_submit.dart';
import 'package:initsurvey/ui/button/button_sync.dart';
import 'package:initsurvey/ui/popups/my_dialog_action.dart';
import 'package:initsurvey/ui/utility/pattern.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        Provider.of<SurveyProvider>(context, listen: false).loadQuestionData();
      },
    );
  }

  Future newSurvey() async {
    await Provider.of<SurveyProvider>(context, listen: false)
        .loadQuestionData();
    if (Provider.of<SurveyProvider>(context, listen: false).hasData == false) {
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Icon(
                Icons.error_outline,
                size: 40,
              ),
              content: Text(
                  AppTranslations.of(context).text('check_connect_and_retry')),
              actions: <Widget>[
                MyDialogAction(AppTranslations.of(context).text('close')),
                MyDialogAction(
                  AppTranslations.of(context).text('retry'),
                  onPressed: newSurvey,
                ),
              ],
            );
          });
    } else {
      Provider.of<SurveyProvider>(context, listen: false).onReset();
      await Navigator.pushNamed(context, '/step-view');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PatternTop(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/images/ui/bottom.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: 15,
              right: 30,
              child: Container(
                alignment: Alignment.topRight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ButtonSync(),
                    const SizedBox(width: 20),
                    _buildLogoutButton(context),
                    LanguageButton(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(32),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppTranslations.of(context).text('home_title'),
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppTranslations.of(context).text('home_body'),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  GradientButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            AppTranslations.of(context)
                                .text('new_survey')
                                .toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    onPressed: newSurvey,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) => PopupMenuButton<int>(
        child: Row(
          children: <Widget>[
            Text(
              Config.instance.user.username,
              style: Theme.of(context)
                  .textTheme
                  .button
                  .merge(TextStyle(color: Theme.of(context).primaryColor)),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
        offset: const Offset(0, 40),
        onSelected: (value) {
          if (value == 1) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.exit_to_app,
                    )),
                Text(
                  AppTranslations.of(context).text('logout'),
                ),
              ],
            ),
            value: 1,
          ),
        ],
      );
}
