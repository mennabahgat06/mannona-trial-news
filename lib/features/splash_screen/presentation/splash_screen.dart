import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mannona_news/features/welcome_screen/welcome_screen.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          // الانتقال لشاشة الترحيب بدلاً من HomeShellScreen
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text('Khaber', style: AppFonts.logoTitle),
      ),
    );
  }
}
