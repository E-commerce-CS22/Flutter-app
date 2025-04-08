import 'Order_item_params.dart';

class CreateOrderParams {
  final List<OrderItemParam> items;
  final String shippingAddress;
  final String paymentMethod;
  final String shippingMethod;
  final String? notes;

  CreateOrderParams({
    required this.items,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.shippingMethod,
    this.notes,
  });

  // دالة لتحويل CreateOrderParams إلى Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'shipping_address': shippingAddress,
      'payment_method': paymentMethod,
      'shipping_method': shippingMethod,
      'notes': notes,
    };
  }
}
