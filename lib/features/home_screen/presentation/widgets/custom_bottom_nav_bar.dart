import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import 'nav_bar_item.dart';

/// Dark rounded bottom bar with 4 tabs.
class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.textDark,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            icon: Icons.home_filled,
            label: 'Home',
            isActive: selectedIndex == 0,
            onTap: () => onItemTapped(0),
          ),
          NavBarItem(
            icon: Icons.explore_outlined,
            label: 'Explore',
            isActive: selectedIndex == 1,
            onTap: () => onItemTapped(1),
          ),
          NavBarItem(
            icon: Icons.bookmark_border_rounded,
            label: 'Bookmark',
            isActive: selectedIndex == 2,
            onTap: () => onItemTapped(2),
          ),
          NavBarItem(
            icon: Icons.cloud_outlined,
            label: 'Weather',
            isActive: selectedIndex == 3,
            onTap: () => onItemTapped(3),
          ),
        ],
      ),
    );
  }
}
