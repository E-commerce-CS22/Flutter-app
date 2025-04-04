import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartstore/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:smartstore/features/wishlist/presentaion/pages/blocs/wishlist_cubit.dart';
import '../../../cart/presentation/models/cart_item.dart';
import '../../../home/presentation/pages/Home/models/constants.dart';
// import '../models/cart_item.dart';

class WishlistTile extends StatelessWidget {
  final WishlistItemEntity item;
  final Function() onRemove;
  const WishlistTile({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            textDirection: TextDirection.rtl, // جعل الاتجاه من اليمين إلى اليسار
            children: [
              Container(
                height: 85,
                width: 85,
                decoration: BoxDecoration(
                  color: kcontentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
            child: const Center(child: Icon(Icons.image, size: 40)), // صورة فارغة مؤقتًا
              ),
              const SizedBox(width: 10), // تقليل المسافة بين الصورة والنص
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight, // يجعل النص أقرب للصورة لكن يبقى في المنتصف
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // يضمن أن العناصر متوسطة داخل العمود
                    crossAxisAlignment: CrossAxisAlignment.center, // يجعل النص في المنتصف أفقيًا
                    children: [
                      Text(
                        item.name,
                        textAlign: TextAlign.center, // يضمن أن النص لا ينحرف كثيرًا
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Text(
                      //   item.product.category,
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.grey.shade400,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "${item.price} ريال",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 30,
          left: 5, // تغيير الاتجاه إلى اليسار ليكون الحذف هناك
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  context.read<WishlistCubit>().deleteItemFromWishlist(item.id);

                },
                icon: const Icon(
                  Ionicons.trash_outline,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              // Container(
              //   height: 40,
              //   decoration: BoxDecoration(
              //     color: kcontentColor,
              //     border: Border.all(
              //       color: Colors.grey.shade200,
              //       width: 2,
              //     ),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Row(
              //     textDirection: TextDirection.rtl, // جعل الأزرار متناسقة مع العربية
              //     children: [
              //       Text(
              //         item.quantity.toString(),
              //         style: const TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       IconButton(
              //         onPressed: onRemove,
              //         iconSize: 18,
              //         icon: const Icon(
              //           Ionicons.remove_outline,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        )
      ],
    );
  }
}
