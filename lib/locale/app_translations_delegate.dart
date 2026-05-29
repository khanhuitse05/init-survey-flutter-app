import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_translations.dart';
import 'application.dart';

class AppTranslationsDelegate
    extends LocalizationsDelegate<AppTranslations> {
  final Locale? newLocale;
  const AppTranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return Application.instance.supportedLanguagesCodes
        .contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) async {
    final SharedPreferences prefInstance =
        await SharedPreferences.getInstance();
    if (!prefInstance.containsKey('language_code')) {
      await prefInstance.setString('language_code', locale.languageCode);
      return AppTranslations.load(locale);
    } else {
      final languageCode = prefInstance.getString('language_code');
      return AppTranslations.load(Locale(languageCode ?? locale.languageCode));
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }
}
