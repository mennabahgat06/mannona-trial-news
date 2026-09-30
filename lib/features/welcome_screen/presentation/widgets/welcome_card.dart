import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../location_screen/presentation/location_search_screen.dart';

/// White rounded card at the bottom of the Welcome screen.
class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Get The Latest News\nAnd Updates',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'From Politics to Entertainment: Your One-Stop Source for '
            'Comprehensive Coverage of the Latest News and Developments '
            'Across the Globe will be right on your hand.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.5, color: AppColors.textGrey, height: 1.6),
          ),
          const SizedBox(height: 28),
          PrimaryButton(
            text: 'Explore',
            icon: Icons.arrow_forward,
            width: 160,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LocationSearchScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
