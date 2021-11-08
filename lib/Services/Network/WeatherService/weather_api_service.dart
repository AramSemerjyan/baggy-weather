import 'package:flutter_weather/Models/Result/request_result.dart';
import 'package:flutter_weather/Models/Weather/weather_model.dart';
import 'package:flutter_weather/Services/Network/Endpoints/endpoints.dart';
import 'package:flutter_weather/Services/Network/base_service/base_service.dart';
import 'package:injectable/injectable.dart';

abstract class WeatherAPIServiceProtocol {
  Future<RequestResult<Forecast>> getForecast({Map<String, dynamic>? params});
}

@Injectable(as: WeatherAPIServiceProtocol)
class WeatherAPIService extends BaseService
    implements WeatherAPIServiceProtocol {
  @override
  Future<RequestResult<Forecast>> getForecast({Map<String, dynamic>? params}) {
    return make(RequestType.get, EndPoints.oneCall, params: params)
        .then((response) {
      final json = response.data;

      if (json != null) {
        return RequestResult(data: Forecast.fromJson(json));
      } else {
        return RequestResult(error: "Something went wrong");
      }
    });
  }
}
