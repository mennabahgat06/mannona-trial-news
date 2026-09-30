import 'package:flutter/material.dart';
import '../../../core/storage/user_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_fonts.dart';
import '../../home_screen/presentation/home_shell_screen.dart';
import '../../welcome_screen/presentation/welcome_screen.dart';

/// Screen 1: shows the logo for 2 seconds.
/// New user -> Welcome.  Returning user (name saved) -> Home.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(const Duration(seconds: 2));
    final name = await UserStorage.getUserName();
    if (!mounted) return;

    final Widget next =
        name == null ? const WelcomeScreen() : const HomeShellScreen();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => next),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Text('Khaber', style: AppFonts.logoTitle)),
    );
  }
}
