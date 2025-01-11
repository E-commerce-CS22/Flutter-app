import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartstore/core/configs/assets/app_vectors.dart';
import 'package:smartstore/features/authentication/presentation/pages/signup_page.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../common/widgets/button/basic_app_button.dart';
import '../../../../core/configs/theme/app_colors.dart';
import '../../../../core/configs/theme/gradient.dart';
import '../../../home/presentation/pages/home.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _logo(context),
                const SizedBox(height: 10),
                _welcomeMessage(context),
                const SizedBox(height: 15),
                _name(context),
                const SizedBox(height: 40),
                _homePageButton(context),
                const SizedBox(height: 20),
                _loginPageButton(context),
                const SizedBox(height: 20),
                _signupPageButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AppVectors.appLogo,
        height: 200,
        width: 200,
        ),
    );
  }

  Widget _welcomeMessage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: GradientText(
          text: 'مرحباً بكم في',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _name(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: Text(
          'smart store',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _homePageButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        AppNavigator.push(context, HomePage()); // Uncomment and replace with actual HomePage
      },
      title: 'تصفح التطبيق',
    );
  }

  Widget _loginPageButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        AppNavigator.push(context, LoginPage()); // Uncomment and replace with actual LoginPage
      },
      title: 'تسجيل الدخول',
    );
  }

  Widget _signupPageButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        AppNavigator.push(context, SignupPage()); // Uncomment and replace with actual SignupPage
      },
      title: 'إنشاء حساب',
    );
  }
}
