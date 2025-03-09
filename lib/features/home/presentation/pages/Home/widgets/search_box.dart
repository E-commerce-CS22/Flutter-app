import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/helper/navigator/app_navigator.dart';
import '../../../../../../core/configs/theme/app_colors.dart';
import '../../../../../ai/ai_page.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            AppNavigator.push(context, ChatPage());
          },
          child: Container(
            width: 50, // تحديد العرض للمربع
            height: 50, // تحديد الارتفاع للمربع
            decoration: BoxDecoration(
              color: Colors.grey[200], // اللون الرمادي للخلفية
              borderRadius: BorderRadius.circular(8), // لتدوير الحواف
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/generative.png', // Path to the image
                width: 50, // حجم الصورة داخل المربع
                height: 50, // حجم الصورة داخل المربع
                color: AppColors.primary, // لون الصورة (إذا أردت تغييرها)
              ),
            ),
          ),
        ),

        SizedBox(width: 10), // Add space between the image and the search box
        Expanded(
          child: TextField(
            textDirection: TextDirection.rtl, // Set text direction to RTL
            decoration: InputDecoration(
              filled: true,
              // fillColor: Colors.grey[200],
              hintText: 'ابحث عن منتج...', // Arabic for "Search for a product..."
              hintTextDirection: TextDirection.rtl, // Hint text direction RTL
              suffixIcon: const Icon(Icons.search, color: Colors.grey), // Move icon to the right
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
            onChanged: (value) {
              // Handle search logic here
            },
          ),
        ),
      ],
    );
  }
}
