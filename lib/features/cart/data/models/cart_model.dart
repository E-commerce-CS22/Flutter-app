import '../../domain/entities/cart_entity.dart';

class CartItemModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final int quantity;

  CartItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    var pivot = map['pivot'] ?? {};

    return CartItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      quantity: pivot['quantity'] as int,
    );
  }

  @override
  String toString() {
    return 'CartItemModel(id: $id, name: $name, price: $price, quantity: $quantity)';
  }

  // // ✅ إضافة دالة copyWith
  // CartItemModel copyWith({i
  //   int? id,
  //   String? name,
  //   String? description,
  //   String? price,
  //   int? quantity,
  // }) {
  //   return CartItemModel(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     description: description ?? this.description,
  //     price: price ?? this.price,
  //     quantity: quantity ?? this.quantity,
  //   );
  // }




}


extension CartXModel on CartItemModel{
  CartItemEntity toEntity() {
    return CartItemEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        quantity: quantity);
  }
}

