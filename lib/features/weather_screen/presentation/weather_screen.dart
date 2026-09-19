import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../data/models/weather_model.dart';
import '../data/services/weather_service.dart';
import 'widgets/weather_info_box.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() => _isLoading = true);
    try {
      final data = await _weatherService.getWeather(
        lat: 30.5877893,
        lon: 31.4798788,
      );
      if (mounted) {
        setState(() {
          _weather = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue))
            : _weather == null
                ? const Center(
                    child: Text('Failed to load weather',
                        style: AppFonts.bodyRegular))
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Good Morning,\nAhmed Saber',
                                    style: AppFonts.caption
                                        .copyWith(color: AppColors.textGrey)),
                                const SizedBox(height: 2),
                                const Text('Sun 9 April, 2023',
                                    style: AppFonts.titleMedium),
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.wb_sunny_outlined,
                                    size: 18, color: AppColors.sunnyYellow),
                                SizedBox(width: 4),
                                Text(
                                    '\${_weather!.condition} \${_weather!.temp.round()}°C',
                                    style: AppFonts.caption),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        const Text(
                            '\${_weather!.cityName} - \${_weather!.country}',
                            style: AppFonts.headerLarge),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '\${_weather!.temp.round()}°',
                              style: TextStyle(
                                fontSize: 64,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                              ),
                            ),
                            Icon(Icons.wb_sunny_rounded,
                                size: 70, color: AppColors.sunnyYellow),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '\${_weather!.condition} - \${_weather!.description}',
                          style: AppFonts.titleMedium.copyWith(fontSize: 18),
                        ),
                        const Text(
                            'Feels like \${_weather!.feelsLike.round()}°',
                            style: AppFonts.caption),
                        const SizedBox(height: 36),

                        // Stats Grid 2x2
                        const Row(
                          children: [
                            Expanded(
                              child: WeatherInfoBox(
                                icon: Icons.thermostat_outlined,
                                value:
                                    '\${((_weather!.temp * 9 / 5) + 32).round()}°',
                                title: 'Fahrenheit',
                              ),
                            ),
                            Expanded(
                              child: WeatherInfoBox(
                                icon: Icons.air,
                                value: '\${_weather!.windSpeed} mp/h',
                                title: 'Wind Speed',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        const Row(
                          children: [
                            Expanded(
                              child: WeatherInfoBox(
                                icon: Icons.speed,
                                value: '\${_weather!.pressure.round()}',
                                title: 'Pressure',
                              ),
                            ),
                            Expanded(
                              child: WeatherInfoBox(
                                icon: Icons.water_drop_outlined,
                                value: '\${_weather!.humidity}%',
                                title: 'Humidity',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 48),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)),
                            ),
                            onPressed: _fetchWeather,
                            icon: const Icon(Icons.location_on,
                                size: 16, color: AppColors.white),
                            label: const Text('Change Location',
                                style: AppFonts.buttonText),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
