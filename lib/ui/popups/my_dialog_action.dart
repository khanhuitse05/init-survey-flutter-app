import 'package:flutter/material.dart';

class MyDialogAction extends StatelessWidget {
  const MyDialogAction(this.text,
      {this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        text,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onPressed: () {
        Navigator.pop(context);
        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }
}
