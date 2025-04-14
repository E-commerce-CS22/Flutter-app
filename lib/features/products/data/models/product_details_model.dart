import 'package:smartstore/features/products/data/models/product_variant_model.dart';
import '../../domain/entities/product_details_entity.dart';
import 'product_entity_model.dart'; // مهم تستورد هذا الملف

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.discountType,
    super.discountValue,
    required super.createdAt,
    required super.updatedAt,
    super.image,
    required super.tags,
    required List<VariantModel> variants,
  }) : super(variants: variants); // Initializing super with variants

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final variantsList = (json['data']['variants'] as List)
        .map((variantJson) => VariantModel.fromJson(variantJson))
        .toList();

    return ProductModel(
      id: json['data']['id'],
      name: json['data']['name'],
      description: json['data']['description'],
      price: double.tryParse(json['data']['price'].toString()) ?? 0.0,
      discountType: json['data']['discount_type'],
      discountValue: json['data']['discount_value'],
      createdAt: DateTime.parse(json['data']['created_at']),
      updatedAt: DateTime.parse(json['data']['updated_at']),
      image: json['data']['image'],
      tags: List<String>.from(json['data']['tags'] ?? []),
      variants: variantsList,
    );
  }
}