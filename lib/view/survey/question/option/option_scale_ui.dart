import 'package:flutter/material.dart';

class OptionScaleUI extends StatelessWidget {
  const OptionScaleUI(this.index, {this.onPressed, this.isChoice});

  final int index;
  final VoidCallback onPressed;
  final bool isChoice;

  final Color _color = Colors.black87;
  final Color _colorHighlight = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          (index + 1).toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isChoice ? _colorHighlight : _color,
          ),
        ),
        IconButton(
          onPressed: onPressed,
           icon: Icon( isChoice
               ? Icons.radio_button_checked
               : Icons.radio_button_unchecked,
               color: isChoice ? _colorHighlight : _color),)
      ],
    );
  }
}
