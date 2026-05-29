import 'package:initsurvey/locale/app_translations.dart';

class Localize {
  String en;
  String vi;

  String get text =>
      appTranslations.locale.languageCode == 'vi' ? vi : en;

  Localize({required this.en, required this.vi});

  Localize.fromJson(Map<String, dynamic> json)
      : en = json['en'] ?? '',
        vi = json['vi'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['vi'] = vi;
    return data;
  }
}
