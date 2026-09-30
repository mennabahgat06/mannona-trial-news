import 'package:shared_preferences/shared_preferences.dart';

/// Saves the user name and the location picked on the map.
class UserStorage {
  static const String _nameKey = 'saved_user_name';
  static const String _latKey = 'saved_lat';
  static const String _lonKey = 'saved_lon';

  // Default location (same as the Postman "weather" request).
  static const double defaultLat = 30.5877893;
  static const double defaultLon = 31.4798788;

  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  static Future<void> saveLocation(double lat, double lon) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latKey, lat);
    await prefs.setDouble(_lonKey, lon);
  }

  static Future<double> getLat() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_latKey) ?? defaultLat;
  }

  static Future<double> getLon() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_lonKey) ?? defaultLon;
  }
}
