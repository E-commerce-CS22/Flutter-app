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
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocProvider(
        create: (context) => AuthStateCubit()..appStarted(),
        child: BlocBuilder<AuthStateCubit, AuthState>(
          builder: (context, state) {
            // التحقق من حالة المصادقة
            if (state is Authenticated) {
              // إذا كان المستخدم مسجلاً، انتقل للصفحة المطلوبة
              return _getPage(_currentIndex);
            } else if (state is UnAuthenticated) {
              // إذا لم يكن المستخدم مسجلاً، عرض صفحة التحذير عند الوصول إلى الصفحات المحمية
              if (_currentIndex == 0 || _currentIndex == 1 || _currentIndex == 3) {
                return UnauthenticatedPage(); // توجيه المستخدم إلى صفحة "غير مسجل"
              } else {
                return _getPage(_currentIndex); // السماح بالدخول للصفحات الأخرى
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      bottomNavigationBar: CurvedNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  // إرجاع الصفحة المطلوبة بناءً على الفهرس
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const ProfilePage();
      case 1:
        return const CartScreen();
      // return CartPage();

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
