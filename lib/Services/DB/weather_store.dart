import 'package:flutter_weather/Helper/Logger/logger.dart';
import 'package:flutter_weather/Models/Weather/weather_model.dart';
import 'package:flutter_weather/Services/DB/data_base_service.dart';
import 'package:injectable/injectable.dart';

abstract class WeatherStoreProtocol {
  Future<Forecast?> getOldForecast();
  Future<bool> saveForecast(Forecast f);
}

@Injectable(as: WeatherStoreProtocol)
class WeatherStore extends DBService implements WeatherStoreProtocol {
  @override
  Future<Forecast?> getOldForecast() async {
    final json = await getForKey('forecast');

    if (json != null) {
      printLog(title: "old forecast", content: json);
      return Forecast.fromJson(json);
    }

    return null;
  }

  @override
  Future<bool> saveForecast(Forecast f) {
    return saveForKey('forecast', f.toJson());
  }
}
