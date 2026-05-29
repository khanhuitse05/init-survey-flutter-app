import 'package:initsurvey/locale/app_translations.dart';
import 'package:flutter/material.dart';
import 'application.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  late Map<String, String> flags;
  late int currentIndex;

  List<String> get languageCodesList =>
      Application.instance.supportedLanguagesCodes;
  String get selectedLanguageCode => appTranslations.currentLanguage;

  @override
  void initState() {
    super.initState();

    flags = {};
    currentIndex = 0;
    for (var i = 0; i < languageCodesList.length; i++) {
      final code = languageCodesList[i];
      flags[code] = 'assets/images/locale/$code.png';
      if (code == selectedLanguageCode) {
        currentIndex = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        clickLanguage(context);
      },
      icon: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset(flags[selectedLanguageCode] ?? flags['en']!),
      ),
    );
  }

  void clickLanguage(BuildContext context) {
    currentIndex++;
    if (currentIndex >= languageCodesList.length) {
      currentIndex = 0;
    }
    Application.instance.changeLanguage(languageCodesList[currentIndex]);
    setState(() {});
  }
}
