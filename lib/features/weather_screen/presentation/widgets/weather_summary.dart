import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/weather_icon_helper.dart';
import '../../data/models/weather_model.dart';

/// City name, big temperature, icon and description.
class WeatherSummary extends StatelessWidget {
  final WeatherModel weather;

  const WeatherSummary({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${weather.cityName} - ${weather.country}',
            style: AppFonts.headerLarge),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${weather.temp.round()}°',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            Icon(WeatherIconHelper.iconFor(weather.condition),
                size: 70, color: AppColors.sunnyYellow),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '${weather.condition} - ${weather.description}',
          style: AppFonts.titleMedium.copyWith(fontSize: 18),
        ),
        Text('Feels like ${weather.feelsLike.round()}°', style: AppFonts.caption),
      ],
    );
  }
}
