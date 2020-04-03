import 'package:flutter/material.dart';

class PatternTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 350,
          child: Image.asset('assets/images/pattern/top.png'),
        ),
      ),
    );
  }
}

class PatternTopRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 70,
      right: 30,
      width: 130,
      child: Image.asset('assets/images/pattern/top-right.png'),
    );
  }
}

class PatternBottomLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 30,
      width: 75,
      height: 85,
      child: Image.asset('assets/images/pattern/bottom-left.png'),
    );
  }
}

class PatternBottomRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Positioned(
      bottom: 0,
      right: 0,
      width: 177,
      height: 97,
      child: Image.asset('assets/images/pattern/bottom-right.png'),
    );
  }
}
