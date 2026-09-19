import 'package:flutter/material.dart';
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
    ExploreScreen(),     // Tab 0: Home / Feed
    ExploreScreen(),     // Tab 1: Explore & Search
    BookmarkScreen(),    // Tab 2: Bookmarks
    WeatherScreen(),     // Tab 3: Weather (Cairo - EG)
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
