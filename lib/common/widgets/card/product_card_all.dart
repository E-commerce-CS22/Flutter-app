import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../features/wishlist/presentaion/pages/blocs/wishlist_cubit.dart';

class ProductCardForAll extends StatelessWidget {
  final int productId;
  final String? imageUrl;
  final String name;
  final double price;
  final VoidCallback onTap;

  const ProductCardForAll({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 180,
            height: 240,  // زيادة الارتفاع قليلاً
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // تضمين الصورة داخل الحدود
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? Image.network(
                    imageUrl!,
                    width: double.infinity,
                    height: 120, // تعديل الارتفاع
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    'assets/images/notFound.jpg',
                    width: double.infinity,
                    height: 140, // تعديل الارتفاع
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                // نص المنتج
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                const Spacer(),
                // السعر
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "$price ريال",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // النقاط الزرقاء (مؤشر الحالة)
                      // Row(
                      //   children: List.generate(
                      //     2,
                      //         (cindex) => Container(
                      //       height: 10,
                      //       width: 10,
                      //       margin: const EdgeInsets.only(left: 3),
                      //       decoration: const BoxDecoration(
                      //         color: Colors.blue,
                      //         shape: BoxShape.circle,
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
          // أيقونة القلب مع أنميشن
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 33,
              height: 33,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: BlocBuilder<WishlistCubit, WishlistState>(
                  builder: (context, state) {
                    bool isInWishlist = false;

                    if (state is WishlistLoaded) {
                      isInWishlist = state.wishlistItems
                          .any((item) => item.id == productId);
                    }

                    return GestureDetector(
                      onTap: () {
                        // تحديث فقط لهذا المنتج
                        if (state is WishlistLoaded) {
                          if (isInWishlist) {
                            context
                                .read<WishlistCubit>()
                                .deleteItemFromWishlist(productId);
                          } else {
                            context
                                .read<WishlistCubit>()
                                .addProductToWishlist(productId);
                          }
                          context.read<WishlistCubit>().getWishlists();
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) =>
                            ScaleTransition(scale: animation, child: child),
                        child: Icon(
                          isInWishlist
                              ? Ionicons.heart
                              : Ionicons.heart_outline,
                          key: ValueKey<bool>(isInWishlist),
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
