import '../../../products/domain/entities/product_image_entity.dart';

class ListProductsEntity {
  final int id;
  final String name;
  final double price;
  final double? discountValue;
  final String? image;
  final List<ProductImageEntity> imageUrls;

  ListProductsEntity({
    required this.id,
    required this.name,
    required this.price,
    this.discountValue,
    this.image,
    required this.imageUrls,
  });
}

