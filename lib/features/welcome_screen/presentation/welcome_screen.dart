import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import 'widgets/buildings_illustration.dart';
import 'widgets/welcome_card.dart';

/// Screen 2: blue background with buildings + white card with "Explore".
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryBlueDark,
      body: Stack(
        children: [
          Positioned(
            top: 70,
            left: 0,
            right: 0,
            height: 340,
            child: Center(child: BuildingsIllustration()),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: WelcomeCard(),
          ),
        ],
      ),
    );
  }
}
