import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/services.dart';  // إضافة هذه المكتبة لتعديل شريط الحالة

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // تعديل شريط الحالة العلوي
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white, // تغيير اللون الخلفي لشريط الحالة إلى الأبيض
        statusBarIconBrightness: Brightness.dark, // جعل الأيقونات في شريط الحالة داكنة
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,  // خلفية بيضاء للأيقونة
              padding: const EdgeInsets.all(15),
            ),
            icon: const Icon(
              Ionicons.chevron_back,
              color: Colors.black,  // اللون الأسود للأيقونة
            ),
          ),
          const Spacer(),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {},
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,  // خلفية بيضاء للأيقونة
              padding: const EdgeInsets.all(15),
            ),
            icon: const Icon(
              Ionicons.heart_outline,
              color: Colors.black,  // اللون الأسود للأيقونة
            ),
          ),
        ],
      ),
    );
  }
}
