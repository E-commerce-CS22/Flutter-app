import 'package:flutter/material.dart';
import '../../../domain/entities/product_image_entity.dart';

class ImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentImage;
  final List<ProductImageEntity> imageUrls;

  const ImageSlider({
    super.key,
    required this.onChange,
    required this.currentImage,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        reverse: true, // عكس الاتجاه من اليمين لليسار
        itemCount: imageUrls.length,
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          final imageUrl = imageUrls[index].url; // نأخذ الـ URL من الـ entity
          return ClipRRect(
            borderRadius: BorderRadius.circular(20), // إضفاء حواف دائرية على الصورة
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/notFound.jpg',
                  fit: BoxFit.cover,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
