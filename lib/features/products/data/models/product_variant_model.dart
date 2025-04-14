import 'package:smartstore/features/products/data/models/product_entity_model.dart';

import '../../domain/entities/product_variant_entity.dart';

class VariantModel extends VariantEntity {
  VariantModel({
    required super.id,
    required super.sku,
    required super.price,
    super.extraPrice,
    required super.stock,
    required super.isDefault,
    required super.variantTitle,
    required List<AttributeModel> attributes,
  }) : super(attributes: attributes);  // Ensuring correct initialization

  factory VariantModel.fromJson(Map<String, dynamic> json) {
    return VariantModel(
      id: json['id'],
      sku: json['sku'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      extraPrice: json['extra_price'],
      stock: json['stock'],
      isDefault: json['is_default'],
      variantTitle: json['variant_title'],
      attributes: (json['attributes'] as List)
          .map((attributeJson) => AttributeModel.fromJson(attributeJson))
          .toList(),
    );
  }
}