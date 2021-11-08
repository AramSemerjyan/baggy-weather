/// As our Base Service will take a URI with Base and Path parts
/// I prefer to create separate object which will be responsible
/// for delivering separate Base and Path parts to Base Service
/// This could be useful (in my case) when we will need custom call
/// with custom API which won't be related to our backend
/// I can call this decoupling Base url from Base Service
/// but I guess that would be too pretentious
class EndPoint {
  final String base;
  final String path;

  EndPoint({required this.base, required this.path});
}

class EndPoints {
  static const String _core = 'openweathermap.org';

  /// Base API for weather service
  static const String _base = "api.$_core";

  /// API to get icon image
  static const String iconUrl = 'https://$_core/img/w/';

  /// This part I use to generate correct base API for different envs
  /// I have a general AppEnv class which is responsible for all configs
  /// configurations and dynamic data that is related to different envs
  static String get _getBase {
    return _base;
  }

  /// collect all needed routs to retrieve desired info
  static String get _weatherAPI => '/data/2.5/';

  /// All api that will be needed in project
  static EndPoint get oneCall => _getEndPointWithPath(_weatherAPI + 'onecall');

  /// Construct EndPoint object based on base API and path
  static EndPoint _getEndPointWithPath(String path) {
    return EndPoint(base: _getBase, path: path);
  }
}
