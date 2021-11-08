import 'package:flutter/material.dart';
import 'package:flutter_weather/Helper/Localization/EN/language_en.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages) ?? LanguageEn();
  }

  String get selectLanguage;

  String get humidity;

  String get windSpeed;

  String get uv;

  String get daily;

  String get hourly;
}
