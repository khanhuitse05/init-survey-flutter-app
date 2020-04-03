import 'package:flutter/material.dart';
import 'package:initsurvey/locale/app_translations.dart';
import 'package:initsurvey/ui/popups/my_dialog_action.dart';

class IconButtonHome extends StatelessWidget {
  const IconButtonHome({this.icon = Icons.home});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        showConfirmQuit(context);
      },
    );
  }

  static Future showConfirmQuit(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(AppTranslations.of(context).text('popup_quit_title')),
            content: Text(AppTranslations.of(context).text('popup_quit_body')),
            actions: <Widget>[
              MyDialogAction(
                AppTranslations.of(context).text("exit"),
                onPressed: () {
                  Navigator.pop(context, ModalRoute.withName('/home'));
                },
              ),
              MyDialogAction(AppTranslations.of(context).text("stay")),
            ],
          );
        });
  }
}
