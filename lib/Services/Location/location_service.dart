import 'package:flutter_weather/Helper/Logger/logger.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

abstract class LocationServiceProtocol {
  Future<LatLng?> getLocation({bool cached = false});
}

class LatLng {
  final double lat;
  final double lng;

  const LatLng({required this.lat, required this.lng});
}

@Injectable(as: LocationServiceProtocol)
class LocationService implements LocationServiceProtocol {
  final _location = Location();

  LatLng? location;

  @override
  Future<LatLng?> getLocation({bool cached = false}) async {
    if (cached && location != null) return location;

    final service = await _service();

    if (service) {
      final permission = await checkPermissionStatus();

      if (permission == PermissionStatus.granted) {
        return _location.getLocation().then((l) {
          final lat = l.latitude;
          final lng = l.longitude;

          printLog(title: 'Location data', content: l);

          if (lat != null && lng != null) {
            location = LatLng(lat: lat, lng: lng);

            return location;
          } else {
            return null;
          }
        }).catchError((e) {
          printLog(title: 'Location error', content: e);
        });
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<PermissionStatus> checkPermissionStatus() async {
    final permissionGranted = await _location.hasPermission();

    printLog(title: "Location permission", content: permissionGranted);

    if (permissionGranted == PermissionStatus.denied) {
      return _location.requestPermission();
    } else {
      return Future.value(permissionGranted);
    }
  }

  /// Private funcs
  Future<bool> _service() async {
    final serviceEnabled = await _location.serviceEnabled();

    printLog(title: 'Location Service status', content: serviceEnabled);

    if (serviceEnabled == true) return Future.value(true);

    return _location.requestService();
  }
}
