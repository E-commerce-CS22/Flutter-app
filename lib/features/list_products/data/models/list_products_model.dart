import '../../domain/entities/list_products_entity.dart';

class ListProductsModel extends ListProductsEntity {
  ListProductsModel({
    required super.id,
    required super.name,
    required super.price,
    super.discountValue,
    super.image,
  });

  factory ListProductsModel.fromJson(Map<String, dynamic> json) {
    return ListProductsModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      discountValue: double.tryParse(json['discount_value']?.toString() ?? '') ?? 0.0,
      image: json['image'],
    );
  }


}
