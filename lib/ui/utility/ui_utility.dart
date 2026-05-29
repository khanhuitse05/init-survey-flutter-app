import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';

IconData get arrowBack {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
    return Icons.arrow_back_ios;
  } else {
    return Icons.arrow_back;
  }
}
