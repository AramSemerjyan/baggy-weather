import 'package:flutter/widgets.dart';
import 'package:flutter_weather/Helper/Localization/EN/language_en.dart';
import 'package:flutter_weather/Helper/Localization/RU/language_ru.dart';
import 'package:flutter_weather/Helper/Localization/languages.dart';

class LocaleDelegate extends LocalizationsDelegate<Languages> {
  const LocaleDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ru'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'ru':
        return LanguageRu();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
