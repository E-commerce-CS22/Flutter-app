import 'package:smartstore/features/orders/domain/entities/orders_state_entity.dart';

class ProductVariantEntityModel {
  final int id;
  final int productId;
  final double price;
  final int extraPrice;
  final int stock;
  final bool isDefault;
  final String variantTitle;

  ProductVariantEntityModel({
    required this.id,
    required this.productId,
    required this.price,
    required this.extraPrice,
    required this.stock,
    required this.isDefault,
    required this.variantTitle,
  });


  ProductVariantEntity toEntity() {
    return ProductVariantEntity(
        id: id,
        productId: productId,
        price: price,
        extraPrice: extraPrice,
        stock: stock,
        isDefault: isDefault,
        variantTitle: variantTitle,
    );
  }

  factory ProductVariantEntityModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantEntityModel(
      id: json['id'],
      productId: json['product_id'],
      price: json['price'],
      extraPrice: json['extra_price'],
      stock: json['stock'],
      isDefault: json['is_default'],
      variantTitle: json['variant_title'],
    );
  }




  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'price': price,
      'extra_price': extraPrice,
      'stock': stock,
      'is_default': isDefault,
      'variant_title': variantTitle,
    };
  }
}
