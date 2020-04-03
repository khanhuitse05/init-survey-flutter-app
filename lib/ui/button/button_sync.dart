import 'package:flutter/material.dart';
import 'package:initsurvey/locale/app_translations.dart';
import 'package:initsurvey/repository/connectivity/connectivity_provider.dart';
import 'package:initsurvey/repository/survey/sync_survey_provider.dart';
import 'package:initsurvey/ui/popups/my_dialog_action.dart';
import 'package:initsurvey/ui/utility/indicator.dart';

import 'package:provider/provider.dart';

class ButtonSync extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SyncSurveyProvider()),
      ],
      child: ButtonSyncChild(),
    );
  }
}

class ButtonSyncChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<SyncSurveyProvider>(context).hasData) {
      if (Provider.of<ConnectivityStatus>(context, listen: false) ==
          ConnectivityStatus.Offline) {
        return buildButton(context, icon: Icon(Icons.sync_problem), onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Icon(
                    Icons.sync_problem,
                    size: 40,
                  ),
                  content: Text(
                      AppTranslations.of(context).text('no_internet_detail')),
                  actions: <Widget>[
                    MyDialogAction(AppTranslations.of(context).text("close"))
                  ],
                );
              });
        });
      } else {
        if (Provider.of<SyncSurveyProvider>(context, listen: false).isLoading) {
          return buildButton(context,
              icon: Container(
                width: 30,
                height: 40,
                child: const Indicator(),
              ));
        } else {
          return buildButton(
            context,
            icon: Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(Icons.sync),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  width: 12,
                  height: 12,
                  child: Text(
                    Provider.of<SyncSurveyProvider>(context)
                        .surveys
                        .length
                        .toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Nunito_Semi_Bold",
                        color: Colors.white),
                  ),
                )
              ],
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Icon(
                        Icons.sync,
                        size: 40,
                      ),
                      content: Text(AppTranslations.of(context)
                          .text('confirm_sync_data')),
                      actions: <Widget>[
                        MyDialogAction(
                          AppTranslations.of(context).text('sync'),
                          onPressed: () {
                            Provider.of<SyncSurveyProvider>(context)
                                .asyncSurveys();
                          },
                        ),
                        MyDialogAction(
                            AppTranslations.of(context).text("close"))
                      ],
                    );
                  });
            },
          );
        }
      }
    } else {
      return buildButton(context, icon: Icon(Icons.sync), onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Icon(
                  Icons.sync,
                  size: 40,
                ),
                content:
                    Text(AppTranslations.of(context).text('no_data_survey')),
                actions: <Widget>[
                  MyDialogAction(AppTranslations.of(context).text("close"))
                ],
              );
            });
      });
    }
  }

  Widget buildButton(BuildContext context,
      {GestureTapCallback onTap, Widget icon}) {
    return FlatButton(
      onPressed: onTap,
      child: Row(
        children: <Widget>[
          Text(
            AppTranslations.of(context).text('sync'),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 5),
          IconTheme(
              data: IconThemeData(color: Theme.of(context).primaryColor),
              child: icon),
        ],
      ),
    );
  }
}
