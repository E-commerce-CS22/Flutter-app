import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/home/presentation/pages/Cart/cart_page.dart';
import 'package:smartstore/features/home/presentation/pages/categories/categories_page.dart';
import 'package:smartstore/features/home/presentation/pages/favorite/favorite_page.dart';
import 'package:smartstore/features/home/presentation/pages/profile/profile_page.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/navbar/bottom_nav_bar.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import 'Home/home_page.dart';
import '../../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../../common/bloc/auth/auth_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 4;

  // List of pages to display
  final List<Widget> _pages = [
    const ProfilePage(), // Profile page is the first page
    const CartScreen(),
    const AllCategoriesPage(),
    const FavoritesPage(),
    const MainPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white, // Match navigation bar color
      body: BlocBuilder<AuthStateCubit, AuthState>(
        builder: (context, state) {
          // Check if user is authenticated
          if (state is Authenticated) {
            // If authenticated, allow access to ProfilePage
            return _pages[_currentIndex];
          } else if (state is UnAuthenticated) {
            // If not authenticated, prevent access to ProfilePage
            if (_currentIndex == 0) {
              // If user tries to go to ProfilePage, show a message or navigate to login
              return const Center(
                child: Text("Please log in to access your profile."),
              );
            } else {
              // Otherwise, allow access to other pages
              return _pages[_currentIndex];
            }
          }
          // Show loading screen or splash while checking auth state
          return const Center(child: CircularProgressIndicator());
        },
      ),
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
