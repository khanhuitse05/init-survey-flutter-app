import 'package:flutter/material.dart';

TextStyle _optionStyle({Color color}) =>
    TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color);

final Color _colorShadowNormal = Colors.grey[400];
final Color _colorNormal = Colors.white;

final Color _colorShadowHighlight = Colors.blue;
final Color _colorHighlight = Colors.blue[50];

class OptionChoiceUI extends StatelessWidget {
  const OptionChoiceUI({this.title, this.onPressed, this.isChoose});

  final String title;
  final VoidCallback onPressed;
  final bool isChoose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isChoose ? _colorHighlight : _colorNormal,
              boxShadow: [
                BoxShadow(
                  color: isChoose ? _colorShadowHighlight : _colorShadowNormal,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: isChoose ? _colorShadowHighlight : _colorShadowNormal,
                  spreadRadius: 1,
                )
              ]),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: _optionStyle(color: isChoose ? Colors.blue : Colors.black87),
          ),
        ),
      ),
    );
  }
}
