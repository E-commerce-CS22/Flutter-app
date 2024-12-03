import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

import '../../../core/configs/theme/app_colors.dart';

class CurvedNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: AppColors.white, // Background behind the bar
      color: AppColors.primary, // Bar color
      buttonBackgroundColor: AppColors.primary, // Active button color
      height: 65,
      items: const <Widget>[
        Icon(Icons.person_outline, size: 40, color: AppColors.white,),
        Icon(Icons.shopping_cart_outlined, size: 40, color: AppColors.white,),
        Icon(Icons.category_outlined, size: 40, color: AppColors.white,),
        Icon(Icons.favorite_outline, size: 40, color: AppColors.white,),
        Icon(Icons.home_outlined, size: 40, color: AppColors.white,),
      ],
      animationDuration: const Duration(milliseconds: 300),
      index: currentIndex,
      onTap: onTap, // Callback for when an item is tapped
    );
  }
}

