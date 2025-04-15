import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../home/presentation/pages/Home/models/constants.dart';
import '../../../domain/entities/cart_entity.dart';
import '../blocs/cart_cubit.dart';


class CartTile extends StatelessWidget {
  final CartItemEntity item;
  final Function() onRemove;
  final Function() onAdd;
  final VoidCallback? onTap;

  const CartTile({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onAdd,
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
            top: 5,
            left: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<CartCubit>().deleteItemFromCart(item.id);
                  },
                  icon: const Icon(
                    Ionicons.trash_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: kcontentColor,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      IconButton(
                        onPressed: onAdd,
                        iconSize: 18,
                        icon: const Icon(
                          Ionicons.add_outline,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: onRemove,
                        iconSize: 18,
                        icon: const Icon(
                          Ionicons.remove_outline,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
