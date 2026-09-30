import 'package:flutter/material.dart';

/// Picks an icon for the OpenWeather "main" condition (Clear, Clouds, Rain...).
class WeatherIconHelper {
  static IconData iconFor(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny_rounded;
      case 'clouds':
        return Icons.cloud_rounded;
      case 'rain':
      case 'drizzle':
        return Icons.water_drop_rounded;
      case 'thunderstorm':
        return Icons.flash_on_rounded;
      case 'snow':
        return Icons.ac_unit_rounded;
      default:
        return Icons.cloud_queue_rounded;
    }
  }
}
