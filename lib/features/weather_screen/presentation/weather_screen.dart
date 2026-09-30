import 'package:flutter/material.dart';
import '../../../core/storage/user_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/primary_button.dart';
import '../../home_screen/presentation/widgets/home_header.dart';
import '../data/models/weather_model.dart';
import '../data/services/weather_service.dart';
import 'widgets/change_location_dialog.dart';
import 'widgets/weather_stats_grid.dart';
import 'widgets/weather_summary.dart';

/// Screen 7 (Tab 3): weather details + "Change Location" (by city name).
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();

  String _userName = '';
  WeatherModel? _weather;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
  }

  /// Weather for the location picked on the map.
  Future<void> _loadSavedLocation() async {
    _userName = await UserStorage.getUserName() ?? '';
    final lat = await UserStorage.getLat();
    final lon = await UserStorage.getLon();
    await _load(() => _weatherService.getWeather(lat: lat, lon: lon));
  }

  Future<void> _load(Future<WeatherModel> Function() request) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final data = await request();
      if (mounted) setState(() => _weather = data);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _changeLocation() async {
    final city = await showDialog<String>(
      context: context,
      builder: (_) => const ChangeLocationDialog(),
    );
    if (city == null || city.isEmpty) return;
    await _load(() => _weatherService.getWeather(cityName: city));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const LoadingView();
    if (_error != null) {
      return ErrorView(message: _error!, onRetry: _loadSavedLocation);
    }

    final weather = _weather!;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(userName: _userName, weather: weather),
            const SizedBox(height: 36),
            WeatherSummary(weather: weather),
            const SizedBox(height: 36),
            WeatherStatsGrid(weather: weather),
            const SizedBox(height: 48),
            PrimaryButton(
              text: 'Change Location',
              icon: Icons.location_on,
              onPressed: _changeLocation,
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: _loadSavedLocation,
                child: const Text('Back to my location',
                    style: TextStyle(color: AppColors.primaryBlue)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
