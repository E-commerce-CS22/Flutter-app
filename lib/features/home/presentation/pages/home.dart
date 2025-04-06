import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/pages/access_denied.dart';
import '../../../../common/widgets/navbar/bottom_nav_bar.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import '../../../categories/presentation/pages/categories_page.dart';
import '../../../profile/presentation/profile_page.dart';
import '../../../wishlist/presentaion/pages/wishlist_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthStateCubit, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          // عند تسجيل الخروج، الانتقال إلى صفحة الترحيب
          Navigator.pushReplacementNamed(context, '/welcome');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocBuilder<AuthStateCubit, AuthState>(
          builder: (context, state) {
            return _getPage(_currentIndex, state);
          },
        ),
        bottomNavigationBar: CurvedNavBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  // إرجاع الصفحة المطلوبة بناءً على الفهرس وحالة المصادقة
  Widget _getPage(int index, AuthState state) {
    if (state is UnAuthenticated && (index == 0 || index == 1 || index == 3)) {
      return UnauthenticatedPage(); // توجيه المستخدم إلى صفحة "أنت لست مسجلًا"
    }

    switch (index) {
      case 0:
        return const ProfilePage();
      case 1:
        return const CartScreen();
      case 2:
        return const AllCategoriesPage();
      case 3:
        return const WishlistScreen();
      case 4:
        return const MainPage();
      default:
        return const MainPage();
    }
  }
}
