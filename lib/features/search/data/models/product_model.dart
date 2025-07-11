import '../../../products/data/models/product_image_model.dart';
import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.createdAt,
    required super.updatedAt,
    required super.image,
    required List<ProductImageModel> imageUrls,

  }): super(imageUrls: imageUrls);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final imageUrlsList = (json['image_urls'] as List)
        .map((image) => ProductImageModel.fromJson(image))
        .toList();
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      image: json['image'],
        imageUrls: imageUrlsList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
