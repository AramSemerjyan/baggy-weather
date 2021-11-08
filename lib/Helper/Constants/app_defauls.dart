import 'package:flutter_weather/Services/Location/location_service.dart';

/// Here we have all default configs that we can have in our app
/// for now it's only default location
class AppDefaults {
  AppDefaults._();

  /// Default location is set to Kiev
  static const coords = LatLng(lat: 50.45466, lng: 30.5238);
}
