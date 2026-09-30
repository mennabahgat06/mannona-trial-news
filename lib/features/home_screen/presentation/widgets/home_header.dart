import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/date_helper.dart';
import '../../../../core/utils/weather_icon_helper.dart';
import '../../../weather_screen/data/models/weather_model.dart';

/// "Good Morning, Name" + today's date + small weather chip.
class HomeHeader extends StatelessWidget {
  final String userName;
  final WeatherModel? weather;

  const HomeHeader({super.key, required this.userName, this.weather});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${DateHelper.greeting()},\n$userName',
                style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
              ),
              const SizedBox(height: 2),
              Text(DateHelper.today(), style: AppFonts.titleMedium),
            ],
          ),
        ),
        if (weather != null)
          Row(
            children: [
              Icon(WeatherIconHelper.iconFor(weather!.condition),
                  size: 18, color: AppColors.sunnyYellow),
              const SizedBox(width: 4),
              Text(
                '${weather!.condition} ${weather!.temp.round()}°C',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
      ],
    );
  }
}
