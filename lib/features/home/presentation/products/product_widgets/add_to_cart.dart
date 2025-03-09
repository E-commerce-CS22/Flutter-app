import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

class AddToCart extends StatelessWidget {
  final Function() onAdd;
  final Function() onRemove;
  final int currentNumber;

  const AddToCart({
    super.key,
    required this.currentNumber,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200], // لون رمادي فاتح
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl, // اتجاه النص من اليمين لليسار
          children: [
            // إضافة زر التقليل والإضافة
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[400]!, // لون رمادي فاتح
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onRemove,
                    iconSize: 18,
                    icon: const Icon(
                      Ionicons.remove_outline,
                      color: Colors.black, // اللون الأسود
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    currentNumber.toString(),
                    style: const TextStyle(color: Colors.black , fontWeight: FontWeight.bold,), // النص باللون الأسود
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: onAdd,
                    iconSize: 18,
                    icon: const Icon(
                      Ionicons.add_outline,
                      color: Colors.black, // اللون الأسود
                      size: 20,

                    ),
                  ),
                ],
              ),
            ),
            // إضافة زر "أضف إلى العربة"
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(60),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: const Text(
                "اضافة الى السلة",
                style: TextStyle(
                  color: Colors.white, // اللون الأسود للنص
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
