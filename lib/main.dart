import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/core/configs/theme/app_theme.dart';
import 'package:smartstore/service_locator.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'common/bloc/auth/auth_state_cubit.dart';
import 'features/ai/consts.dart';
import 'features/authentication/presentation/blocs/user_display_cubit.dart';
import 'features/cart/presentation/pages/blocs/cart_cubit.dart';
import 'features/categories/presentation/blocs/category_cubit.dart';
import 'features/orders/presentation/blocs/cancel_order_cubit.dart';
import 'features/splash/presentation/pages/splash.dart';
import 'features/wishlist/presentaion/pages/blocs/wishlist_cubit.dart';

void main() {
  // إعداد الـ Service Locator
  setupServiceLocator();

  // تهيئة Gemini API
  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthStateCubit()..appStarted()),
        BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
        BlocProvider(create: (context) => CategoryCubit()..displayCategories()),
        BlocProvider(create: (context) => CartCubit()..getCartItems()),
        BlocProvider(create: (context) => WishlistCubit()..getCartItems()),
        BlocProvider(create: (context) =>  CancelOrderCubit())

      ],
      child: MaterialApp(
        title: 'Smart Store',
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(), // صفحة البداية
      ),
    );
  }
}
