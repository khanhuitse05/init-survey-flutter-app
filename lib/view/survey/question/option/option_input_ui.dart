import 'package:flutter/material.dart';

final Color _colorShadowNormal = Colors.grey.shade400;
const Color _colorNormal = Colors.white;

const Color _colorShadowHighlight = Colors.blue;
final Color _colorHighlight = Colors.blue.shade50;

class OptionInputUI extends StatelessWidget {
  const OptionInputUI({required this.child, required this.isChoose});

  final bool isChoose;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
      child: child,
    );
  }
}
