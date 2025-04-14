import '../../domain/entities/product_image_entity.dart';

class ProductImageModel extends ProductImageEntity {
  ProductImageModel({
    required super.url,
    required super.isPrimary,
    required super.altText,
    required super.sortOrder,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      url: json['url'],
      isPrimary: json['is_primary'],
      altText: json['alt_text'],
      sortOrder: json['sort_order'],
    );
  }
}
