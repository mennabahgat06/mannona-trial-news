import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../bookmark_screen/presentation/bookmark_screen.dart';
import '../../explore_screen/presentation/explore_screen.dart';
import '../../weather_screen/presentation/weather_screen.dart';
import 'home_screen.dart';
import 'widgets/custom_bottom_nav_bar.dart';

/// Holds the 4 tabs and the bottom navigation bar.
class HomeShellScreen extends StatefulWidget {
  const HomeShellScreen({super.key});

  @override
  State<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends State<HomeShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(), // 0: Home feed
    ExploreScreen(), // 1: Explore
    BookmarkScreen(), // 2: Bookmark
    WeatherScreen(), // 3: Weather
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavBar(
          selectedIndex: _currentIndex,
          onItemTapped: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
