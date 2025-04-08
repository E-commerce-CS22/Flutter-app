class OrderItemParam {
  final int productId;
  final int productVariantId;
  final int quantity;

  OrderItemParam({
    required this.productId,
    required this.productVariantId,
    required this.quantity,
  });

  // دالة لتحويل OrderItemParam إلى Map<String, dynamic>
  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'product_variant_id': productVariantId,
    'quantity': quantity,
  };
}
