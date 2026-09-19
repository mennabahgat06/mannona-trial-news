import 'package:flutter/material.dart';
import 'package:mannona_news/features/location_screen/presentation/location_search_screen.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            height: 380,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                  child: Icon(Icons.location_city_rounded,
                      size: 140, color: Colors.white70)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Get The Latest News\nAnd Updates',
                      textAlign: TextAlign.center, style: AppFonts.headerLarge),
                  const SizedBox(height: 12),
                  const Text(
                    'From Politics to Entertainment: Your One-\nStop Source for Comprehensive Coverage\nof the Latest News and Developments\nAcross the Glob will be right on your hand.',
                    textAlign: TextAlign.center,
                    style: AppFonts.bodyRegular,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: 170,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LocationSearchScreen())),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Explore', style: AppFonts.buttonText),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward,
                              size: 16, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
