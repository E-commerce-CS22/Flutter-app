import 'package:flutter/material.dart';
import 'package:smartstore/common/helper/navigator/app_navigator.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

import '../../features/authentication/presentation/pages/login_page.dart';

class UnauthenticatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/cannotaccess.png', // تأكد من إضافة الصورة إلى مجلد assets
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "أنت غير مسجل!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "يجب عليك تسجيل الدخول للوصول إلى هذه الصفحة.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  AppNavigator.push(context, LoginPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "تسجيل الدخول",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}