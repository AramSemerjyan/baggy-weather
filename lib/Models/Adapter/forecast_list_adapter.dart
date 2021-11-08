import 'package:flutter_weather/Models/Adapter/forecast_item_ui_adapter.dart';
import 'package:flutter_weather/Models/Weather/weather_model.dart';
import 'package:flutter_weather/UI/Forecast/ForecastDetailsView/forecast_details.dart';

enum ForecastListType { hourly, daily }

abstract class ForecastListUIInterface {
  String get icon;
  String get temp;
  String get title;
}

class ForecastListUIAdapter extends ForecastItemUIAdapterBase
    implements ForecastListUIInterface, ForecastItemDetailsUIInterface {
  final ForecastListType listType;

  @override
  String get icon => toIconUrl(forecast.weather.first.iconId);

  @override
  String get temp => toShortTemp(forecast.temp);

  @override
  String get title => listType == ForecastListType.hourly
      ? toHour(forecast.dt)
      : toDay(forecast.dt);

  @override
  String get humidity => toHumidity(forecast.humidity);

  @override
  String get uv => forecast.uvi.toString();

  @override
  String get windSpeed => toWindSpeed(forecast.windSpeed);

  ForecastListUIAdapter({required ForecastItem item, required this.listType})
      : super(forecast: item);
}
