import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/services.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';

import '../../../../wishlist/presentaion/pages/blocs/wishlist_cubit.dart'; // إضافة هذه المكتبة لتعديل شريط الحالة

class ProductAppBar extends StatelessWidget {
  final int productId;

  const ProductAppBar({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    // تعديل شريط الحالة العلوي
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        // تغيير اللون الخلفي لشريط الحالة إلى الأبيض
        statusBarIconBrightness: Brightness
            .dark, // جعل الأيقونات في شريط الحالة داكنة
      ),
    );


    return BlocListener<WishlistCubit, WishlistState>(
      listener: (context, state) {
        if (state is WishlistError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.grey,
              duration: const Duration(seconds: 2),
            ),
          );
        }
        },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white, // خلفية بيضاء للأيقونة
                padding: const EdgeInsets.all(15),
              ),
              icon: const Icon(
                Ionicons.chevron_back,
                color: Colors.black, // اللون الأسود للأيقونة
              ),
            ),
            const Spacer(),
            const SizedBox(width: 5),
            IconButton(
              onPressed: () {
                final wishlistCubit = context.read<WishlistCubit>();

                if (wishlistCubit.state is WishlistLoaded) {
                  final isInWishlist = (wishlistCubit.state as WishlistLoaded)
                      .wishlistItems
                      .any((item) => item.id == productId);

                  if (isInWishlist) {
                    wishlistCubit.deleteItemFromWishlist(productId);
                    wishlistCubit.getWishlists();
                  } else {
                    wishlistCubit.addProductToWishlist(productId);
                    wishlistCubit.getWishlists();
                  }
                }
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white, // خلفية بيضاء للأيقونة
                padding: const EdgeInsets.all(15),
              ),
              icon: BlocBuilder<WishlistCubit, WishlistState>(
                builder: (context, state) {
                  bool isInWishlist = false;

                  if (state is WishlistLoaded) {
                    isInWishlist =
                        state.wishlistItems.any((item) => item.id == productId);
                  }
                  return Icon(
                    isInWishlist ? Ionicons.heart : Ionicons.heart_outline,
                    color: isInWishlist ? Colors.red : Colors.black,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
