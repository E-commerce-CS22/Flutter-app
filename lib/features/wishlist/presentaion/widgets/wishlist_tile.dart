import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartstore/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:smartstore/features/wishlist/presentaion/pages/blocs/wishlist_cubit.dart';
import '../../../home/presentation/pages/Home/models/constants.dart';

class WishlistTile extends StatelessWidget {
  final WishlistItemEntity item;
  final Function() onRemove;
  final VoidCallback? onTap;

  const WishlistTile({
    super.key,
    required this.item,
    required this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    color: kcontentColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Center(child: Icon(Icons.image, size: 40)), // صورة مؤقتة
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${item.price} ريال",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 5,
            child: IconButton(
              onPressed: () {
                context.read<WishlistCubit>().deleteItemFromWishlist(item.id);
              },
              icon: const Icon(
                Ionicons.trash_outline,
                color: Colors.red,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
