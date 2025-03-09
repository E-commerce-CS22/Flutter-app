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
      backgroundColor: AppColors.white,
      color: AppColors.primary,
      buttonBackgroundColor: AppColors.primary,
      height: 60,
      items: <Widget>[
        _NavBarItem(
          icon: Image.asset('assets/icons/user_2.png', width: 30, height: 30, color: Colors.white,),
          label: 'حسابي',
          isSelected: currentIndex == 0,
        ),
        _NavBarItem(
          icon: Image.asset('assets/icons/online-shopping.png', width: 30, height: 30, color: Colors.white,),
          label: 'السلة',
          isSelected: currentIndex == 1,
        ),
        _NavBarItem(
          icon: Image.asset('assets/icons/category.png', width: 30, height: 30, color: Colors.white,),
          label: 'الفئات',
          isSelected: currentIndex == 2,
        ),
        _NavBarItem(
          icon: Image.asset('assets/icons/heart_2.png', width: 30, height: 30, color: Colors.white,),
          label: 'المفضلة',
          isSelected: currentIndex == 3,
        ),
        _NavBarItem(
          icon: Image.asset('assets/icons/home.png', width: 30, height: 30, color: Colors.white,),
          label: 'الرئيسية',
          isSelected: currentIndex == 4,
        ),
      ],
      animationDuration: const Duration(milliseconds: 300),
      index: currentIndex,
      onTap: onTap,
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final Widget icon;
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
        SizedBox(height: 32, child: icon),
        if (!isSelected) ...[
          const SizedBox(height: 0),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}