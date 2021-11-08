import 'package:flutter_weather/Models/Adapter/forecast_list_adapter.dart';

abstract class ForecastEvent {}

class ForecastRequest extends ForecastEvent {}

class ForecastChangeListType extends ForecastEvent {
  final ForecastListType type;

  ForecastChangeListType({required this.type});
}
