import 'dart:async';
import 'package:flutter_weather/Helper/Constants/app_keys.dart';
import 'package:flutter_weather/Models/Result/request_result.dart';
import 'package:flutter_weather/Models/Weather/weather_model.dart';
import 'package:flutter_weather/Services/DB/weather_store.dart';
import 'package:flutter_weather/Services/Location/location_service.dart';
import 'package:flutter_weather/Services/Network/WeatherService/weather_api_service.dart';
import 'package:injectable/injectable.dart';

/// This should be as Facade (did I get the name right? or the pattern? O_o)
/// it should handle providing Forecast and all things that should be done with data
/// hidden from user like store it, get the cached one before making an backend request
abstract class WeatherServiceProtocol {
  Future<Forecast?> getOldForecast();
  Future<RequestResult<Forecast>> updateForecast({required LatLng location});
}

@Injectable(as: WeatherServiceProtocol)
class WeatherService implements WeatherServiceProtocol {
  final WeatherAPIServiceProtocol _weatherAPIService;
  final WeatherStoreProtocol _weatherStoreProtocol;

  WeatherService(WeatherAPIServiceProtocol api, WeatherStoreProtocol store)
      : _weatherAPIService = api,
        _weatherStoreProtocol = store;

  @override
  Future<Forecast?> getOldForecast() {
    return _weatherStoreProtocol.getOldForecast();
  }

  @override
  Future<RequestResult<Forecast>> updateForecast({required LatLng location}) {
    return _weatherAPIService.getForecast(params: {
      'lat': location.lat.toString(),
      'lon': location.lng.toString(),
      'appid': AppKeys.weatherAPIkey,
      'units': 'metric'
    }).then((r) {
      final forecast = r.data;

      if (forecast != null) {
        _weatherStoreProtocol.saveForecast(forecast);
      }

      return r;
    });
  }
}
