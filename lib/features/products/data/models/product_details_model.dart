import '../../domain/entities/product_details_entity.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.tags,
    super.discountType,
    super.discountValue,
    // required super.variants,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    var data = json['data']; // استخراج البيانات من مفتاح "data"
    return ProductDetailsModel(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      price: double.tryParse(data['price'].toString()) ?? 0.0,
      tags: List<String>.from(data['tags'] ?? []),
      discountType: data['discount_type'],
      discountValue: data['discount_value'] != null
          ? double.tryParse(data['discount_value'].toString())
          : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'tags': tags,
      'discount_type': discountType,
      'discount_value': discountValue,
    };
  }
}
