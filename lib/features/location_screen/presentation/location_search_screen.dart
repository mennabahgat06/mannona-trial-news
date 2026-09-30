import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/storage/user_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/primary_button.dart';
import '../../home_screen/presentation/home_shell_screen.dart';
import 'widgets/location_map.dart';
import 'widgets/name_input_bar.dart';

/// Screen 3: user types a name and taps the map to pick a location.
/// Both are saved and used later by Home + Weather.
class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController _nameController = TextEditingController();
  final MapController _mapController = MapController();

  LatLng _selectedPoint =
      const LatLng(UserStorage.defaultLat, UserStorage.defaultLon);

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onGetStarted() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name first.')),
      );
      return;
    }

    await UserStorage.saveUserName(name);
    await UserStorage.saveLocation(
        _selectedPoint.latitude, _selectedPoint.longitude);
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeShellScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          LocationMap(
            controller: _mapController,
            selectedPoint: _selectedPoint,
            onPointSelected: (point) => setState(() => _selectedPoint = point),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: NameInputBar(controller: _nameController),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppColors.white,
              onPressed: () => _mapController.move(_selectedPoint, 14),
              child: const Icon(Icons.my_location, color: AppColors.primaryBlue),
            ),
          ),
          Positioned(
            bottom: 36,
            left: 24,
            right: 24,
            child: PrimaryButton(text: 'Get Started', onPressed: _onGetStarted),
          ),
        ],
      ),
    );
  }
}
