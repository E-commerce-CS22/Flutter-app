import 'package:flutter/material.dart';
import '../../models/cart_item.dart';

class CheckOutBox extends StatelessWidget {
  final List<CartItem> items;
  const CheckOutBox({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl, // جعل النصوص من اليمين لليسار
            children: [
              const Text(
                "الإجمالي",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${items.length > 1 ? items.map<double>((e) => e.quantity * e.product.price).reduce((value1, value2) => value1 + value2) : items[0].product.price * items[0].quantity} ريال",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl, // تحديد اتجاه النص من اليمين إلى اليسار
              ),



            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // لون أزرق غامق لمظهر أنيق
              minimumSize: const Size(double.infinity, 55),
            ),
            child: const Text(
              "المتابعة للشراء",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
