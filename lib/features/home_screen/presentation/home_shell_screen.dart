import 'package:flutter/material.dart';
import 'package:mannona_news/features/home_screen/home_screen.dart';
import '../../../../core/utils/app_colors.dart';
import '../../explore_screen/presentation/explore_screen.dart';
import '../../bookmark_screen/presentation/bookmark_screen.dart';
import '../../weather_screen/presentation/weather_screen.dart';
import 'widgets/custom_bottom_nav_bar.dart';

class HomeShellScreen extends StatefulWidget {
  const HomeShellScreen({super.key});

  @override
  State<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends State<HomeShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(), // Tab 0: Home Feed الجديد
    ExploreScreen(), // Tab 1: Explore
    BookmarkScreen(), // Tab 2: Bookmark
    WeatherScreen(), // Tab 3: Weather
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
