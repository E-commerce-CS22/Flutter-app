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
import 'features/list_products/presentation/blocs/list_products_cubit.dart';
import 'features/orders/presentation/blocs/cancel_order_cubit.dart';
import 'features/orders/presentation/blocs/create_order_bloc/create_order_cubit.dart';
import 'features/products_by_category/presentation/blocs/get_product_by_cateogry_cubit.dart';
import 'features/profile/presentation/bloc/user_update_cubit.dart';
import 'features/search/presentation/blocs/search_cubit.dart';
import 'features/sliders/presentation/blocs/sliders_cubit.dart';
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
        BlocProvider(create: (context) => WishlistCubit()..getWishlists()),
        BlocProvider(create: (context) =>  CancelOrderCubit()),
        BlocProvider(create: (context) => ProductsByCategoryCubit()),
        BlocProvider(create: (context) => UserUpdateCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => CreateOrderCubit()),
        BlocProvider(create: (context) => SlidersCubit()..fetchSliders()),
        BlocProvider(create: (context) => ListProductsCubit()..fetchListProducts(3)),






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
