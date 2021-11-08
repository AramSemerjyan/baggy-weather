import 'package:flutter_weather/Pages/Weather/weather_bloc.dart';
import 'package:flutter_weather/Services/WeatherService/weather_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

/// Here I decided to use another package for DI... because I really like how
/// things implemented here!! Annotations... I imagine myself as a real developer
/// when I use annotations...
final _getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void _configureDependencies() => $initGetIt(_getIt);

class AppInjection {
  static configure() => _configureDependencies();

  /// Weather
  static WeatherServiceProtocol get weatherService => _getIt.get();

  static WeatherBloc get forecastBloc => _getIt.get();
}
