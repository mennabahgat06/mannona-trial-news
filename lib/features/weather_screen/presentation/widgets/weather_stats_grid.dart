import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import 'weather_info_box.dart';

/// 2 x 2 grid: Fahrenheit, Wind, Pressure, Humidity.
class WeatherStatsGrid extends StatelessWidget {
  final WeatherModel weather;

  const WeatherStatsGrid({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: WeatherInfoBox(
                icon: Icons.thermostat_outlined,
                value: '${weather.fahrenheit.round()}°',
                title: 'Fahrenheit',
              ),
            ),
            Expanded(
              child: WeatherInfoBox(
                icon: Icons.air,
                value: '${weather.windSpeed} m/s',
                title: 'Wind Speed',
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: WeatherInfoBox(
                icon: Icons.speed,
                value: '${weather.pressure} hPa',
                title: 'Pressure',
              ),
            ),
            Expanded(
              child: WeatherInfoBox(
                icon: Icons.water_drop_outlined,
                value: '${weather.humidity}%',
                title: 'Humidity',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
