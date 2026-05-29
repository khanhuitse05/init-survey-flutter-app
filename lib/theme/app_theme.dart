import 'package:flutter/material.dart';

ThemeData primaryTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    secondary: Colors.orange,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    actionsIconTheme: IconThemeData(
      color: Colors.black87,
    ),
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    height: 40,
    textTheme: ButtonTextTheme.normal,
  ),
  iconTheme: const IconThemeData(color: Colors.black87),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);
