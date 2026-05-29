import 'dart:async';
import 'dart:convert';
import 'package:initsurvey/core/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

import 'application.dart';

late AppTranslations appTranslations;

class AppTranslations {
  Map<dynamic, dynamic> localisedValues = {};

  AppTranslations(Locale newLocale) {
    locale = newLocale;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations)!;
  }

  static Future<AppTranslations> load(Locale locale) async {
    appTranslations = AppTranslations(locale);
    Map<dynamic, dynamic> _tmpLocale;
    final String _localeCode = locale.languageCode;
    for (int i = 0;
        i < Application.instance.locale[_localeCode]!.length;
        i++) {
      final String jsonContent = await rootBundle.loadString(
          'assets/locale/$_localeCode/${Application.instance.locale[_localeCode]![i]}.json');
      _tmpLocale = json.decode(jsonContent);
      appTranslations.localisedValues.addAll(_tmpLocale);
    }
    try {
      final response = await http
          .get(Uri.parse(
              '${Application.instance.remoteUrl}remote_${locale.languageCode}.json'))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        if (Utility.isNullOrEmpty(response.body) == false) {
          _tmpLocale = json.decode(utf8.decode(response.bodyBytes));
          appTranslations.localisedValues.addAll(_tmpLocale);
        }
      }
    } catch (e) {
      debugPrint('Decode locale remote fail');
    }
    return appTranslations;
  }

  late Locale locale;
  String get currentLanguage => locale.languageCode;

  bool isKeyExist(String key) => localisedValues.containsKey(key);

  String text(String key) {
    return localisedValues[key]?.toString() ?? key;
  }

  String textFormat(String key, List<dynamic> replace) {
    String _value = localisedValues[key]?.toString() ?? key;
    for (int i = 0; i < replace.length; i++) {
      _value = _value.replaceAll('{$i}', replace[i].toString());
    }
    return _value;
  }
}
