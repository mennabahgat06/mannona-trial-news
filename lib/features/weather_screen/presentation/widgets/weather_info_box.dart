import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

class WeatherInfoBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;

  const WeatherInfoBox({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 26, color: AppColors.primaryBlue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textLightGrey)),
          ],
        ),
      ],
    );
  }
}
