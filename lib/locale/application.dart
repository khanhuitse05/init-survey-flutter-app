import 'dart:async';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static final Application instance = Application._internal();

  factory Application() => instance;

  Application._internal();

  final List<String> supportedLanguages = ['English', 'Tiếng việt'];

  final List<String> supportedLanguagesCodes = ['en', 'vi'];

  final remoteUrl =
      'http://dev-mobileapp.bigc.vn:8080/files/mobile-app/locale/';

  final locale = {
    'en': ['main', 'common'],
    'vi': ['main', 'common']
  };

  Iterable<Locale> supportedLocales() =>
      supportedLanguagesCodes.map<Locale>((language) => Locale(language));

  final onLocaleChanged = StreamController<Locale>.broadcast();

  Future<void> changeLanguage(String languageCode) async {
    final prefInstance = await SharedPreferences.getInstance();
    await prefInstance.setString('language_code', languageCode);
    onLocaleChanged.add(Locale(languageCode));
  }
}
