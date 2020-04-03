import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  accentColor: Colors.orange,
  /// App bar theme
  appBarTheme: AppBarTheme(
    color: Colors.white,
    brightness: Brightness.light,
    actionsIconTheme: const IconThemeData(
      color: Colors.black87,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black87,
    ),
  ),

  /// button
  buttonTheme: const ButtonThemeData(
    height: 40,
//    shape: StadiumBorder(),
    textTheme: ButtonTextTheme.normal,
  ),
  iconTheme: const IconThemeData(color: Colors.black87),

  /// Support swipe from edge to navigate the previous scene
  /// for both iOS and android
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
