import 'package:flutter_weather/Helper/DateFormat/date_formats.dart';
import 'package:flutter_weather/Models/Weather/weather_model.dart';
import 'package:flutter_weather/Services/Network/Endpoints/endpoints.dart';
import 'package:flutter_weather/UI/Forecast/CurrentForecast/forecast_info.dart';
import 'package:flutter_weather/UI/Forecast/ForecastDetailsView/forecast_details.dart';
import 'package:intl/intl.dart';

/// In the future we may want to have different type of temp
/// I don't know if this is needed, I just write what my sleepy mind tell me to write
enum TempType { celsius, fahrenheit }

/// This class will adopt ForecastItem model to UI, which means (in my sick mind)
/// It will convert nums to String with corresponding prefixes or postfixes
class ForecastItemUIAdapterBase {
  final ForecastItem forecast;
  final TempType type;

  ForecastItemUIAdapterBase(
      {required this.forecast, this.type = TempType.celsius});

  String toFullTemp(num temp) => "$temp°C";
  String toShortTemp(num temp) => "$temp°";

  String toHumidity(num hum) => "$hum%";

  String toWindSpeed(num wind) => "$wind m/s";

  String toHour(int dt) => DateFormat(DateFormats.hour).format(_toDate(dt));

  String toDay(int dt) => DateFormat(DateFormats.day).format(_toDate(dt));

  String toIconUrl(String icon) =>
      EndPoints.iconUrl + forecast.weather.first.iconId + '.png';

  /// Private helpers
  DateTime _toDate(int dt) => DateTime.fromMillisecondsSinceEpoch(dt * 1000);
}

class ForecastItemUIAdapter extends ForecastItemUIAdapterBase
    implements ForecastItemlUIInterface, ForecastItemDetailsUIInterface {
  @override
  String get feelsLike => toShortTemp(forecast.temp);

  @override
  String get icon => toIconUrl(forecast.weather.first.iconId);

  @override
  String get temp => toFullTemp(forecast.temp);

  @override
  String get shortTemp => toShortTemp(forecast.temp);

  @override
  String get humidity => toHumidity(forecast.humidity);

  @override
  String get uv => forecast.uvi.toString();

  @override
  String get windSpeed => toWindSpeed(forecast.windSpeed);

  @override
  String get day => toDay(forecast.dt);

  @override
  String get hour => toHour(forecast.dt);

  int get some => forecast.dt;

  ForecastItemUIAdapter({required ForecastItem forecastItem})
      : super(forecast: forecastItem);
}

abstract class ForecastUIInterface {
  String get timezone;
  ForecastItemlUIInterface get current;
  List<ForecastItemlUIInterface> get daily;
  List<ForecastItemlUIInterface> get hourly;
}

class ForecastUIAdapter extends ForecastUIInterface {
  final Forecast _model;

  ForecastUIAdapter(this._model);

  @override
  ForecastItemlUIInterface get current =>
      ForecastItemUIAdapter(forecastItem: _model.current);

  @override
  List<ForecastItemlUIInterface> get daily =>
      _model.daily.map((e) => ForecastItemUIAdapter(forecastItem: e)).toList();

  @override
  List<ForecastItemlUIInterface> get hourly =>
      _model.hourly.map((e) => ForecastItemUIAdapter(forecastItem: e)).toList();

  @override
  String get timezone => _model.timezone;
}
