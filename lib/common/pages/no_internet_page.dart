import 'package:flutter/material.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import '../../features/splash/presentation/pages/splash.dart';

class NoInternetPage extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetPage({Key? key, required this.onRetry}) : super(key: key);

  void _handleRetry(BuildContext context) {
    // استبدال صفحة "لا يوجد اتصال" بـ "SplashPage" لإعادة الفحص
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashPage()),
    );
  }

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
                'assets/images/no_internet.png', // أضف الصورة إلى مجلد assets
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  "عذرًا!\nلا يوجد اتصال بالإنترنت",
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
                child: const Text(
                  "يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _handleRetry(context), // استدعاء الدالة عند الضغط
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  "إعادة المحاولة",
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
