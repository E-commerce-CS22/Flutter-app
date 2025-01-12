import 'package:flutter/material.dart';
import 'package:smartstore/features/home/presentation/pages/Cart/cart_page.dart';
import 'package:smartstore/features/home/presentation/pages/categories/categories_page.dart';
import 'package:smartstore/features/home/presentation/pages/favorite/favorite_page.dart';
import 'package:smartstore/features/home/presentation/pages/profile/profile_page.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/navbar/bottom_nav_bar.dart';
import '../../../../core/configs/theme/app_colors.dart';
import 'Home/home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 4;

  // List of pages to display
  final List<Widget> _pages = [
    const ProfilePage(), // Updated to use ProfilePage
    const CartPage(),
    const AllCategoriesPage(),
    const FavoritesPage(),
    const MainPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Match navigation bar color
      body: _pages[_currentIndex], // Display the current page
      bottomNavigationBar: CurvedNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update the current page index
          });
        },
      ),
    );
  }
}
