import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartstore/common/widgets/appbar/app_bar.dart';
import 'package:smartstore/common/widgets/button/basic_app_button.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import '../../../../common/helper/navigator/app_navigator.dart';
import '../../../../core/configs/theme/app_theme.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _nameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  final TextEditingController _confirmPasswordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CurvedAppBar(
        title: Text("إنشاء حساب"),
        hideBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _welcomeMessage(context),
            const SizedBox(height: 5),
            _description(context),
            const SizedBox(height: 30),
            _nameField(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            _confirmPasswordField(context),
            const SizedBox(height: 20),
            _signupButton(context),
            const SizedBox(height: 10),
            _loginInstead(context),
          ],
        ),
      ),
    );
  }

  Widget _welcomeMessage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          'مرحباً بك!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _description(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          'أدخل المعلومات لإنشاء حساب جديد',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _nameField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _nameCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          hintText: 'الاسم الكامل',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _emailCon,
        textAlign: TextAlign.right,
        decoration: const InputDecoration(
          hintText: 'البريد الإلكتروني',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _passwordCon,
        textAlign: TextAlign.right,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'كلمة السر',
          alignLabelWithHint: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _confirmPasswordField(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: _confirmPasswordCon,
        textAlign: TextAlign.right,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'تأكيد كلمة السر',
          alignLabelWithHint: true,
        ),
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _signupButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        // Add signup logic here
      },
      title: 'إنشاء حساب',
    );
  }

  Widget _loginInstead(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "هل لديك حساب؟ ",
                style: AppTheme.blackTextStyle,
              ),
              TextSpan(
                text: 'تسجيل الدخول',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.pop(context); // Navigate back to login
                  },
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Almarai',
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
