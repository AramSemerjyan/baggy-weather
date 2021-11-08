/// Usually I use json_serializable package (https://pub.dev/packages/json_serializable)
/// to automatically generate from/to json funcs, but that solution creates a lot of
/// .g.dart files inside corresponding Model folder and I don't want to make folder
/// structure too nested and heavy (and most probably I will make it) so I'll do
/// everything manually
///
/// Also in some cases (like models) I'll prefer to hope that API will always return
/// needed keys in JSON, but I understand that it could be null too
/// (I'm from swift where optionals is not something new), so this is just to
/// save time :)
class Weather {
  final int id;
  final String main;
  final String description;
  final String iconId;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.iconId});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      iconId: json['icon']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'main': main, 'description': description, 'icon': iconId};
}

/// After getting a decoder issue because of wrong type (I mostly write int instead of double)
/// I decided to clear properties a little bit.
///
/// I've chosen `num` as type because for same property API can return int or double
class ForecastItem {
  final int dt;
  final int temp;
  final num feelsLike;
  final num pressure;
  final num humidity;
  final num uvi;
  final num clouds;
  final num visibility;
  final num windSpeed;
  final num windDeg;
  final num windGust;
  final List<Weather> weather;

  ForecastItem({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) => ForecastItem(
      dt: json['dt'],
      temp: (json['temp'] as num).toInt(),
      feelsLike: json['feels_like'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      uvi: json['uvi'],
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: json['wind_speed'],
      windDeg: json['wind_deg'],
      windGust: json['wind_gust'],
      weather:
          (json['weather'] as List).map((e) => Weather.fromJson(e)).toList());

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'feels_like': feelsLike,
        'pressure': pressure,
        'humidity': humidity,
        'uvi': uvi,
        'clouds': clouds,
        'visibility': visibility,
        'wind_speed': windSpeed,
        'wind_deg': windDeg,
        'wind_gust': windGust,
        'weather': weather.map((e) => e.toJson()).toList()
      };
}

/// On this stage I asked myself a question "Why do I copy every single key from response"
/// But at this point it was to late to stop...
///
/// Also I've probably forget to improve this class
/// Daily and hourly items are slightly different and it would be nice to create
/// separate classes (maybe with same parent class), but to save time for now
/// I'll left it as is to test and find all issue that I've made while writing
/// model parsing part
///
/// Have you noticed? Have you noticed how I wrote the toJson func? Two Objects
/// for hourly and daily forecast were so similar... that I just didn't want to
/// make separate models for them... but then later... I understood the issue...
/// and I just didn't have time to fix it :)
class Forecast {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final ForecastItem current;
  final List<ForecastItem> hourly;
  final List<ForecastItem> daily;

  Forecast(
      {required this.lat,
      required this.lon,
      required this.timezone,
      required this.timezoneOffset,
      required this.current,
      required this.daily,
      required this.hourly});

  /// TODO: hourly forecast is for 48 hours
  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
      lat: json['lat'],
      lon: json['lon'],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: ForecastItem.fromJson(json['current']),
      daily: (json['daily'] as List).map((e) {
        Map<String, dynamic> json = e;
        json['temp'] = json['temp']['max'];
        json['feels_like'] = json['feels_like']['day'];

        return ForecastItem.fromJson(json);
      }).toList(),
      hourly: (json['hourly'] as List)
          .map((e) => ForecastItem.fromJson(e))
          .toList());

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
        'timezone': timezone,
        'timezone_offset': timezoneOffset,
        'current': current.toJson(),
        'daily': daily.map((e) {
          final temp = e.toJson();
          temp['temp'] = {'max': temp['temp']};
          temp['feels_like'] = {'day': temp['feels_like']};

          return temp;
        }).toList(),
        'hourly': hourly.map((e) => e.toJson()).toList()
      };
}
