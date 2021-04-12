import 'package:shared_preferences/shared_preferences.dart';

import 'logger.dart';

class SharedPrefs {
  static void setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<bool> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  static void setPosition(double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', latitude);
    await prefs.setDouble('longitude', longitude);
  }

  static Future<Map<dynamic, dynamic?>?> getPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<dynamic, dynamic?>? position;
    try {
      position = {
        'latitude': prefs.getDouble('latitude'),
        'longitude': prefs.getDouble('longitude')
      };
    } catch (e) {
      logger.e(e);
    }
    return position;
  }
}
