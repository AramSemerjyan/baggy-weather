import 'package:flutter_weather/Models/Adapter/forecast_list_adapter.dart';
import 'package:flutter_weather/UI/Forecast/CurrentForecast/forecast_info.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';

/// I almost sure that I have to have Error state for any kind of errors...
/// but I came up with one completion state... I really want to discuss a lot of...
/// from here with you...
abstract class ForecastState {}

class ForecastInitial extends ForecastState {}

class ForecastIsLoading extends ForecastState {}

class ForecastLoadedComplete extends ForecastState {
  final ForecastItemlUIInterface? current;
  final List<ForecastListUIAdapter> list;
  final ForecastListType dropDownValue;
  final WeatherType currentType;
  final String locationName;
  final String? error;

  ForecastLoadedComplete(
      {required this.current,
      required this.list,
      required this.dropDownValue,
      required this.currentType,
      required this.locationName,
      this.error});
}
