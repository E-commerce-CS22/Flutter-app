import 'package:smartstore/features/orders/data/models/product_model.dart';
import 'package:smartstore/features/orders/data/models/product_variant_model.dart';

class OrderItemEntityModel {
  final int id;
  final int productId;
  final ProductEntityModel product;
  final int productVariantId;
  final ProductVariantEntityModel productVariant;
  final int quantity;
  final String unitPrice;
  final String subtotal;
  final String discountAmount;

  OrderItemEntityModel({
    required this.id,
    required this.productId,
    required this.product,
    required this.productVariantId,
    required this.productVariant,
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.discountAmount,
  });

  factory OrderItemEntityModel.fromJson(Map<String, dynamic> json) {
    return OrderItemEntityModel(
      id: json['id'],
      productId: json['product_id'],
      product: ProductEntityModel.fromJson(json['product']),
      productVariantId: json['product_variant_id'],
      productVariant: ProductVariantEntityModel.fromJson(json['product_variant']),
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      subtotal: json['subtotal'],
      discountAmount: json['discount_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product': product.toJson(),
      'product_variant_id': productVariantId,
      'product_variant': productVariant.toJson(),
      'quantity': quantity,
      'unit_price': unitPrice,
      'subtotal': subtotal,
      'discount_amount': discountAmount,
    };
  }
}
