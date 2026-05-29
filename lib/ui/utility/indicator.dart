import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({this.radius = 15});
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return Center(
        child: CupertinoActivityIndicator(
          radius: radius,
        ),
      );
    } else {
      return Center(
        child: SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
        ),
      );
    }
  }
}
