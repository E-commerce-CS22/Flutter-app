import '../../domain/entities/orders_state_entity.dart';

class   ProductEntityModel {
  final int id;
  final String name;
  final String description;
  final String price;

  ProductEntityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  // دالة لتحويل الـ Model إلى Entity
  ProductEntity toEntity() {
    return ProductEntity(
        id: id,
        name: name,
        description: description,
        price: price,
    );
  }

  factory ProductEntityModel.fromJson(Map<String, dynamic> json) {
    return ProductEntityModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
