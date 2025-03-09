import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
// import 'package:shop_example/screens/product_screen.dart';

import '../../../products/product_screen.dart';
import '../models/constants.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductScreen(product: product),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: kcontentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Allow the column to take minimum space
              children: [
                Image.asset(
                  product.image,
                  width: 90,
                  height: 90,
                ),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textDirection: TextDirection.rtl, // Make the text RTL
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${product.price} ريال",
                      textDirection: TextDirection.rtl,  // تحديد الاتجاه من اليمين لليسار
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        product.colors.length,
                            (cindex) => Container(
                          height: 10,
                          width: 15,
                          margin: const EdgeInsets.only(left: 2), // Change the margin for RTL
                          decoration: BoxDecoration(
                            color: product.colors[cindex],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft, // Move the icon to the left
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), // Changed to topLeft for RTL
                    bottomRight: Radius.circular(10), // Changed to bottomRight for RTL
                  ),
                ),
                child: const Icon(
                  Ionicons.heart_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
