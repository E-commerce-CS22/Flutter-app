import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

class CurvedNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: AppColors.white, // Background behind the bar
      color: AppColors.primary, // Bar color
      buttonBackgroundColor: AppColors.primary, // Active button color
      height: 60, // Increased height to accommodate text
      items: <Widget>[
        _NavBarItem(icon: Icons.person, label: 'حسابي', isSelected: currentIndex == 0),
        _NavBarItem(icon: Icons.shopping_cart_outlined, label: 'السلة', isSelected: currentIndex == 1),
        _NavBarItem(icon: Icons.category_outlined, label: 'الفئات', isSelected: currentIndex == 2),
        _NavBarItem(icon: Icons.favorite_outline, label: 'المفضلة', isSelected: currentIndex == 3),
        _NavBarItem(icon: Icons.home, label: 'الرئيسية', isSelected: currentIndex == 4),
      ],
      animationDuration: const Duration(milliseconds: 300),
      index: currentIndex,
      onTap: onTap, // Callback for when an item is tapped
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 30,
          color: AppColors.white,
        ),
        // Text will be hidden when the item is selected
        if (!isSelected) ...[
          const SizedBox(height: 4), // Space between icon and text
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
