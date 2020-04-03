import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  const SelectButton({this.title, this.onPressed, this.isSelect = false});

  final String title;
  final VoidCallback onPressed;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Text(
            title,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
          )),
          Icon(
            isSelect
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: isSelect ? Theme.of(context).primaryColor : Colors.black87,
          ),
        ],
      ),
    );
  }
}
