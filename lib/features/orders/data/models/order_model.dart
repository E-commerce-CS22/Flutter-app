import 'dart:convert';

import '../../domain/entities/orders_state_entity.dart';
import 'order_item_model.dart';

class OrderEntityModel {
  final int id;
  final String totalAmount;
  final String status;
  final String paymentMethod;
  final String shippingAddress;
  final String? notes;
  final String? trackingNumber;
  final List<OrderItemEntityModel> items;
  final String createdAt;
  final String updatedAt;

  OrderEntityModel({
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

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      totalAmount: totalAmount,
      status: status,
      paymentMethod: paymentMethod,
      shippingAddress: shippingAddress,
      notes: notes,
      trackingNumber: trackingNumber,
      items: items.map((item) => item.toEntity()).toList(),  // تحويل العناصر إلى Entity
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }

  factory OrderEntityModel.fromJson(Map<String, dynamic> json) {
    return OrderEntityModel(
      id: json['id'],
      totalAmount: json['total_amount'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      shippingAddress: json['shipping_address'],
      notes: json['notes'],
      trackingNumber: json['tracking_number'],
      items: List<OrderItemEntityModel>.from(
          json['items'].map((item) => OrderItemEntityModel.fromJson(item))),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total_amount': totalAmount,
      'status': status,
      'payment_method': paymentMethod,
      'shipping_address': shippingAddress,
      'notes': notes,
      'tracking_number': trackingNumber,
      'items': items.map((item) => item.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
