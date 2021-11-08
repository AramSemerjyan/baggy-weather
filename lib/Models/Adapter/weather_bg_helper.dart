import 'package:flutter_weather_bg/flutter_weather_bg.dart';

/// This is class for Weather model to cast it to get WeaterType for WeatherBg
/// widget. I don't know why I'm wasting my time for creating something that is not
/// included in the requirements list... but... anyway...
class WeatherBGHelper {
  // 200 - thunderstorm with light rain	 11d
  // 201 - thunderstorm with rain	 11d
  // 202 - thunderstorm with heavy rain	 11d
  // 210 - light thunderstorm	 11d
  // 211 - thunderstorm	 11d
  // 212 - heavy thunderstorm	 11d
  // 221 - ragged thunderstorm	 11d
  // 230 - thunderstorm with light drizzle	 11d
  // 231 - thunderstorm with drizzle	 11d
  // 232 - thunderstorm with heavy drizzle	 11d
  static final _thunderIds = [200, 201, 202, 210, 211, 212, 221, 230, 231, 232];

  /*
  300 - light
  301 - drizzle
  302 - heavy intensity drizzle
  310 - light intensity drizzle rain
  311 - drizzle rain
  312 - heavy intensity drizzle rain
  313 - shower rain and drizzle
  314 - heavy shower rain and drizzle
  321 - shower drizzle
  */
  static final _drizzleIds = [
    300,
    301,
    302,
    310,
    311,
    312,
    313,
    314,
    321,
  ];

  // 500	Rain	light rain	 10d
  // 501	Rain	moderate rain	 10d
  // 502	Rain	heavy intensity rain	 10d
  // 503	Rain	very heavy rain	 10d
  // 504	Rain	extreme rain	 10d
  // 511	Rain	freezing rain	 13d
  // 520	Rain	light intensity shower rain	 09d
  // 521	Rain	shower rain	 09d
  // 522	Rain	heavy intensity shower rain	 09d
  // 531	Rain	ragged shower rain	 09d
  static final _rainIds = [
    500,
    501,
    502,
    503,
    504,
    511,
    520,
    521,
    522,
    531,
  ];

  // 600	Snow	light snow	 13d
  // 601	Snow	Snow	 13d
  // 602	Snow	Heavy snow	 13d
  // 611	Snow	Sleet	 13d
  // 612	Snow	Light shower sleet	 13d
  // 613	Snow	Shower sleet	 13d
  // 615	Snow	Light rain and snow	 13d
  // 616	Snow	Rain and snow	 13d
  // 620	Snow	Light shower snow	 13d
  // 621	Snow	Shower snow	 13d
  // 622	Snow	Heavy shower snow	 13d
  static final _showIds = [
    600,
    601,
    602,
    611,
    612,
    613,
    615,
    616,
    620,
    621,
    622,
  ];

  // 701	Mist	mist	 50d
  // 711	Smoke	Smoke	 50d
  // 721	Haze	Haze	 50d
  // 731	Dust	sand/ dust whirls	 50d
  // 741	Fog	fog	 50d
  // 751	Sand	sand	 50d
  // 761	Dust	dust	 50d
  // 762	Ash	volcanic ash	 50d
  // 771	Squall	squalls	 50d
  // 781	Tornado	tornado	 50d
  static final _atmosphere = [
    701,
    711,
    721,
    731,
    741,
    751,
    761,
    762,
    771,
    781,
  ];

  final clearIds = [
    800,
  ];

  // 801	Clouds	few clouds: 11-25%	 02d
  // 802	Clouds	scattered clouds: 25-50%	 03d
  // 803	Clouds	broken clouds: 51-84%	 04d
  // 804	Clouds	overcast clouds: 85-100%	 04d
  static final _cloudsIds = [
    801,
    802,
    803,
    804,
  ];

  static WeatherType typeFor(int id) {
    if (id >= 200 && id <= 232) return WeatherType.thunder;
    if (id >= 500 && id <= 531) return WeatherType.middleRainy;
    if (id >= 600 && id <= 622) return WeatherType.lightSnow;
    if (id >= 701 && id <= 781) return WeatherType.foggy;
    if (id == 800) return WeatherType.sunny;

    return WeatherType.cloudy;
  }
}
