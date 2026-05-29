import 'package:flutter/material.dart';

import 'app_translations.dart';
import 'application.dart';

class LanguageSelectorPage extends StatefulWidget {
  const LanguageSelectorPage({super.key});

  @override
  State<LanguageSelectorPage> createState() => _LanguageSelectorPageState();
}

class _LanguageSelectorPageState extends State<LanguageSelectorPage> {
  List<String> get languagesList => Application.instance.supportedLanguages;

  List<String> get languageCodesList =>
      Application.instance.supportedLanguagesCodes;

  String get selectedLanguageCode => appTranslations.currentLanguage;

  String get selectedLanguage => languagesMap[selectedLanguageCode] ?? '';

  late Map<String, String> languagesMap;

  @override
  void initState() {
    super.initState();
    languagesMap = {};
    for (var i = 0; i < languageCodesList.length; i++) {
      languagesMap[languageCodesList[i]] = languagesList[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppTranslations.of(context).text('setting_language'),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppTranslations.of(context).text('setting_language_title'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RadioGroup<String>(
                groupValue: selectedLanguageCode,
                onChanged: onChangeMyLanguage,
                child: Column(
                  children: languageCodesList
                      .map((item) => buildButtonLanguage(context, item))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButtonLanguage(BuildContext context, String code) {
    return Row(
      children: <Widget>[
        Radio<String>(
          activeColor: Theme.of(context).primaryColor,
          value: code,
        ),
        InkWell(
          onTap: () {
            onChangeMyLanguage(code);
          },
          child: Text(
            languagesMap[code] ?? '',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }

  void onChangeMyLanguage(String? value) {
    if (value == null) return;
    Application.instance.changeLanguage(value);

    setState(() {});
  }
}
