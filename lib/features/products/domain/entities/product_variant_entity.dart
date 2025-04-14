import 'attribute_entity.dart';

class VariantEntity {
  final int id;
  final String sku;
  final double price;  // No need for nullability here if every variant should have a price
  final double? extraPrice;
  final int stock;
  final bool isDefault;
  final String? variantTitle;
  final List<AttributeEntity> attributes;

  VariantEntity({
    required this.id,
    required this.sku,
    required this.price,
    this.extraPrice,
    required this.stock,
    required this.isDefault,
    required this.variantTitle,
    required this.attributes,
  });
}

