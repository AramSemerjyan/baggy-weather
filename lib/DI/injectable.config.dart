// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../Pages/Weather/weather_bloc.dart' as _i7;
import '../Services/DB/weather_store.dart' as _i5;
import '../Services/Location/location_service.dart' as _i3;
import '../Services/Network/WeatherService/weather_api_service.dart' as _i4;
import '../Services/WeatherService/weather_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.LocationServiceProtocol>(() => _i3.LocationService());
  gh.factory<_i4.WeatherAPIServiceProtocol>(() => _i4.WeatherAPIService());
  gh.factory<_i5.WeatherStoreProtocol>(() => _i5.WeatherStore());
  gh.factory<_i6.WeatherServiceProtocol>(() => _i6.WeatherService(
      get<_i4.WeatherAPIServiceProtocol>(), get<_i5.WeatherStoreProtocol>()));
  gh.factory<_i7.WeatherBloc>(() => _i7.WeatherBloc(
      get<_i6.WeatherServiceProtocol>(), get<_i3.LocationServiceProtocol>()));
  return get;
}
