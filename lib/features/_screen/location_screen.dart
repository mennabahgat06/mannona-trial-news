import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mannona_news/features/home_screen/presentation/home_shell_screen.dart';
import '../../../../core/storage/bookmark_storage.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Ahmed Saber');
  final MapController _mapController = MapController();

  // إحداثيات الموقع الافتراضي (القاهرة)
  LatLng _currentPosition = const LatLng(30.0444, 31.2357);

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onGetStarted() async {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      await BookmarkStorage.saveUserName(name);
    }
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeShellScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // الخريطة التفاعلية الحية
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 13.0,
              onTap: (tapPosition, point) {
                setState(() {
                  _currentPosition =
                      point; // تغيير مكان الدبوس عند الضغط على أي مكان بالخريطة
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.mannona.news',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.location_on,
                      size: 45,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // شريط إدخال اسم المستخدم العلوي
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person_outline,
                        color: AppColors.textGrey, size: 20),
                    hintText: 'Enter your name...',
                  ),
                ),
              ),
            ),
          ),

          // زر إعادة تمركز الخريطة
          Positioned(
            bottom: 100,
            right: 20,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppColors.white,
              onPressed: () {
                _mapController.move(_currentPosition, 14.0);
              },
              child:
                  const Icon(Icons.my_location, color: AppColors.primaryBlue),
            ),
          ),

          // زر Get Started السفلي
          Positioned(
            bottom: 36,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                ),
                onPressed: _onGetStarted,
                child: const Text('Get Started', style: AppFonts.buttonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
