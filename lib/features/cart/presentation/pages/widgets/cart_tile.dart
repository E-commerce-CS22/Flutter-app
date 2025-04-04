import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../home/presentation/pages/Home/models/constants.dart';
import '../../../domain/entities/cart_entity.dart';
import '../blocs/cart_cubit.dart';
// import '../../models/cart_item_entity.dart';  // تأكد من أن `CartItemEntity` تم استيراده بشكل صحيح.


class CartTile extends StatelessWidget {
  final CartItemEntity item; // تم تغيير النوع إلى CartItemEntity
  final Function() onRemove;
  final Function() onAdd;

  const CartTile({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onAdd,
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
                  color: kcontentColor, // تلوين الخلفية مؤقتًا
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
                        item.name, // تم استخدام name بدلاً من title
                        textAlign: TextAlign.center, // يضمن أن النص لا ينحرف كثيرًا
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          "${item.price} ريال", // تم استخدام price
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
          top: 5,
          left: 5, // تغيير الاتجاه إلى اليسار ليكون الحذف هناك
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  // استدعاء دالة الحذف من CartCubit عند الضغط على زر الحذف
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
                  textDirection: TextDirection.rtl, // جعل الأزرار متناسقة مع العربية
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
                      item.quantity.toString(), // تم استخدام quantity
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
    );
  }
}
