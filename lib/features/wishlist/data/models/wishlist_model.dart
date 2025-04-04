import '../../domain/entities/wishlist_entity.dart';

class WishlistItemModel {
  final int id;
  final String name;
  final String description;
  final String price;

  WishlistItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory WishlistItemModel.fromMap(Map<String, dynamic> map) {

    return WishlistItemModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
    );
  }

  @override
  String toString() {
    return 'WishlistItemModel(id: $id, name: $name, price: $price)';
  }
}


extension WishlistXModel on WishlistItemModel{
  WishlistItemEntity toEntity() {
    return WishlistItemEntity(
        id: id,
        name: name,
        description: description,
        price: price,);
  }
}