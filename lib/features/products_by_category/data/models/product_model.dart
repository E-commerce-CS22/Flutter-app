import 'package:smartstore/features/products_by_category/domain/entities/products_by_category_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.finalPrice,
    required super.hasDiscount,
    super.primaryImage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      finalPrice: double.parse(json['final_price'].toString()),
      hasDiscount: json['has_discount'],
      primaryImage: json['primary_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'final_price': finalPrice,
      'has_discount': hasDiscount,
      'primary_image': primaryImage,
    };
  }
}
