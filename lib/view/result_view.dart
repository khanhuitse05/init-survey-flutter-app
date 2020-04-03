import 'package:flutter/material.dart';
import 'package:initsurvey/locale/app_translations.dart';
import 'package:initsurvey/ui/button/gradient_submit.dart';
import 'package:initsurvey/ui/utility/pattern.dart';

class ResultView extends StatelessWidget {
  const ResultView(this.message);

  final Map message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PatternTop(),
            PatternBottomRight(),
            PatternBottomLeft(),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    // shrinkWrap: true,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      Container(
                        height: 200,
                        child: Image.asset("assets/images/ui/survey-icon.png"),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        AppTranslations.of(context).text('lw_congratulation'),
                        style: Theme.of(context)
                            .textTheme
                            .display1
                            .merge(TextStyle(color: Colors.green)),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppTranslations.of(context).text("lw_win_detail"),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      GradientButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                AppTranslations.of(context)
                                    .text('lw_win_btn')
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
                        onPressed: () {
                          Navigator.popUntil(
                              context, ModalRoute.withName('/home'));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
