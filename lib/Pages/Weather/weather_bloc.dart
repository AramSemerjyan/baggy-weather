import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/Helper/Constants/app_defauls.dart';
import 'package:flutter_weather/Models/Adapter/forecast_item_ui_adapter.dart';
import 'package:flutter_weather/Models/Adapter/forecast_list_adapter.dart';
import 'package:flutter_weather/Models/Adapter/weather_bg_helper.dart';
import 'package:flutter_weather/Models/Weather/weather_model.dart';
import 'package:flutter_weather/Pages/Weather/weather_event.dart';
import 'package:flutter_weather/Pages/Weather/weather_state.dart';
import 'package:flutter_weather/Services/Location/location_service.dart';
import 'package:flutter_weather/Services/WeatherService/weather_service.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';
import 'package:injectable/injectable.dart';

@injectable
class WeatherBloc extends Bloc<ForecastEvent, ForecastState> {
  final LocationServiceProtocol _locationService;
  final WeatherServiceProtocol _weatherServiceProtocol;

  Forecast? _currentForecast;

  WeatherBloc(WeatherServiceProtocol weatherService,
      LocationServiceProtocol locationService)
      : _weatherServiceProtocol = weatherService,
        _locationService = locationService,
        super(ForecastInitial());

  @override
  Stream<ForecastState> mapEventToState(ForecastEvent event) async* {
    if (event is ForecastRequest) {
      yield ForecastIsLoading();

      _currentForecast = await _weatherServiceProtocol.getOldForecast();

      if (_currentForecast != null) {
        yield _collectState(_currentForecast, ForecastListType.hourly, null);
      }

      final location =
          (await _locationService.getLocation()) ?? AppDefaults.coords;

      final response =
          await _weatherServiceProtocol.updateForecast(location: location);
      final forecast = response.data;

      if (forecast != null) {
        _currentForecast = forecast;
        yield _collectState(forecast, ForecastListType.hourly, null);
      } else {
        yield _collectState(_currentForecast, ForecastListType.hourly,
            response.error ?? "Something went wrong");
      }
    }

    if (event is ForecastChangeListType) {
      yield _collectState(_currentForecast, event.type, null);
    }
  }

  List<ForecastItem> _getForecastListItems(
      Forecast? forecast, ForecastListType type) {
    switch (type) {
      case ForecastListType.hourly:
        return forecast?.hourly ?? [];
      case ForecastListType.daily:
        return forecast?.daily ?? [];
    }
  }

  List<ForecastListUIAdapter> _getListAdapter(
      List<ForecastItem>? items, ForecastListType type) {
    if (items == null) return [];

    return items
        .map((e) => ForecastListUIAdapter(item: e, listType: type))
        .toList();
  }

  ForecastItemUIAdapter? _getItemAdapter(ForecastItem? item) =>
      item != null ? ForecastItemUIAdapter(forecastItem: item) : null;

  WeatherType _getWeatherType(Forecast? forecast) {
    final id = forecast?.current.weather.first.id;

    return id != null ? WeatherBGHelper.typeFor(id) : WeatherType.sunny;
  }

  String _getLocationName(String? timezone) => timezone ?? "Undefined";

  ForecastLoadedComplete _collectState(
      Forecast? forecast, ForecastListType listType, String? error) {
    return _getLoadCompleteState(
        current: _getItemAdapter(forecast?.current),
        list: _getListAdapter(
            _getForecastListItems(forecast, listType), listType),
        type: _getWeatherType(forecast),
        dropDownValue: listType,
        locationName: _getLocationName(forecast?.timezone),
        error: error);
  }

  ForecastLoadedComplete _getLoadCompleteState(
      {ForecastItemUIAdapter? current,
      List<ForecastListUIAdapter> list = const [],
      WeatherType type = WeatherType.sunny,
      ForecastListType dropDownValue = ForecastListType.hourly,
      String locationName = "Undefined",
      String? error}) {
    return ForecastLoadedComplete(
        current: current,
        list: list,
        error: error,
        dropDownValue: dropDownValue,
        currentType: type,
        locationName: locationName);
  }
}
