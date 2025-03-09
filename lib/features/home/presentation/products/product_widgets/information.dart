import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../pages/Home/models/constants.dart';
import '../../pages/Home/models/product.dart';

class ProductInfo extends StatelessWidget {
  final Product product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,  // تعديل المحاذاة من اليسار لليمين
      children: [
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,  // عكس اتجاه النص من اليسار لليمين
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,  // إضافة المحاذاة من اليمين
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,  // تعديل المحاذاة هنا أيضًا
              children: [
                Text(
                  "${product.price} ريال",
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,  // عكس اتجاه النص
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,  // عكس الاتجاه بحيث يبدأ من اليمين
                  children: [

                    const Text(
                      "(320 تقييم)",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textDirection: TextDirection.rtl,  // عكس اتجاه النص
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 50,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Ionicons.star,
                            size: 13,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            product.rate.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
