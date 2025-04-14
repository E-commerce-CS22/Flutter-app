import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

class ProductDescription extends StatelessWidget {
  final String text;
  const ProductDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end, // تعديل لمحاذاة المحتوى من اليمين
      children: [
        const Text(
          ":وصف المنتج",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          text,
          style: const TextStyle(
            color: Colors.grey,
          ),
          textDirection: TextDirection.rtl, // عكس اتجاه النص من اليسار لليمين
        )
      ],
    );
  }
}
