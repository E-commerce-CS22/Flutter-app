class OrderEntity {
  final int id;
  final String totalAmount;
  final String status;
  final String paymentMethod;
  final String shippingAddress;
  final String? notes;
  final String? trackingNumber;
  final List<OrderItemEntity> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderEntity({
    required this.id,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    required this.shippingAddress,
    this.notes,
    this.trackingNumber,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });
}

class OrderItemEntity {
  final int id;
  final int productId;
  final ProductEntity product;
  final int productVariantId;
  final ProductVariantEntity productVariant;
  final int quantity;
  final String unitPrice;
  final String subtotal;
  final String discountAmount;

  OrderItemEntity({
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
}

class ProductEntity {
  final int id;
  final String name;
  final String description;
  final String price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
}

class ProductVariantEntity {
  final int id;
  final int productId;
  final double price;
  final double extraPrice;
  final int stock;
  final bool isDefault;
  final String variantTitle;

  ProductVariantEntity({
    required this.id,
    required this.productId,
    required this.price,
    required this.extraPrice,
    required this.stock,
    required this.isDefault,
    required this.variantTitle,
  });
}
