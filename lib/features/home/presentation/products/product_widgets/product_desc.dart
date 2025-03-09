import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import '../../pages/Home/models/constants.dart';

class ProductDescription extends StatelessWidget {
  final String text;
  const ProductDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end, // تعديل لمحاذاة المحتوى من اليمين
      children: [
        Container(
          width: 110,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.primary,
          ),
          alignment: Alignment.center,
          child: const Text(
            "وصف المنتج",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
