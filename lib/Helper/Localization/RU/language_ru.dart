import 'package:flutter_weather/Helper/Localization/languages.dart';

class LanguageRu extends Languages {
  @override
  String get selectLanguage => "Выбрать язык";

  @override
  String get humidity => "Влажность";

  @override
  String get uv => "УФ";

  @override
  String get windSpeed => "Скорость ветра";

  @override
  String get daily => "По дням";

  @override
  String get hourly => "По часам";
}
