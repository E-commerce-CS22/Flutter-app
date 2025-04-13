import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/core/configs/assets/app_vectors.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import 'package:smartstore/features/home/presentation/pages/home.dart';
import 'package:smartstore/features/authentication/presentation/pages/welcome_page.dart';
import '../../../../common/bloc/auth/auth_state.dart';
import '../../../../common/bloc/auth/auth_state_cubit.dart';
import '../../../../common/pages/no_internet_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isCheckingInternet = true; // لمنع BlocListener من العمل قبل انتهاء الفحص

  @override
  void initState() {
    super.initState();
    _handleSplashLogic();
  }

  Future<void> _handleSplashLogic() async {
    await Future.delayed(const Duration(seconds: 2)); // مدة الـ Splash

    var connectivityResult = await Connectivity().checkConnectivity();

    if (!mounted) return; // التأكد من أن الصفحة لا تزال نشطة

    if (connectivityResult == ConnectivityResult.none) {
      // في حالة عدم وجود إنترنت، انتقل إلى صفحة "لا يوجد اتصال"
      AppNavigator.pushReplacement(
        context,
        NoInternetPage(onRetry: () {
          AppNavigator.pushReplacement(context, const SplashPage());
        }),
      );
    } else {
      // إذا كان هناك إنترنت، اسمح لـ BlocListener بالعمل
      setState(() {
        _isCheckingInternet = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCheckingInternet
          ? _buildSplashScreen() // عرض شاشة التحميل أثناء الفحص
          : BlocListener<AuthStateCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            AppNavigator.pushReplacement(context, const HomePage());
          } else if (state is UnAuthenticated) {
            AppNavigator.pushReplacement(context, WelcomePage());
          }
        },
        child: _buildSplashScreen(),
      ),
    );
  }

  Widget _buildSplashScreen() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradient1, AppColors.gradient2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppVectors.appLogo2,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
