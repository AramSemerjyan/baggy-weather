import 'dart:convert';
import 'package:flutter_weather/Helper/Logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// For future implementation this could be replaced with SQL or any other DB
/// we want
abstract class DBService {
  Future<SharedPreferences> instance = SharedPreferences.getInstance();

  Future<Map<String, dynamic>?> getForKey(String key) async {
    final db = await instance;

    final string = db.getString(key);

    if (string != null) {
      printLog(title: "DB JSON", content: string);
      return json.decode(string);
    }

    return null;
  }

  Future<bool> saveForKey(String key, Map<String, dynamic> model) async {
    final db = await instance;

    final string = json.encode(model);

    return db.setString(key, string);
  }
}
