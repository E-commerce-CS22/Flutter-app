import '../../../products/data/models/product_image_model.dart';
import '../../domain/entities/list_products_entity.dart';

class ListProductsModel extends ListProductsEntity {
  ListProductsModel({
    required super.id,
    required super.name,
    required super.price,
    super.discountValue,
    super.image,
    required List<ProductImageModel> imageUrls,

  }): super(imageUrls: imageUrls);

  factory ListProductsModel.fromJson(Map<String, dynamic> json) {
    final imageUrlsList = (json['image_urls'] as List)
        .map((image) => ProductImageModel.fromJson(image))
        .toList();
    return ListProductsModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      discountValue: double.tryParse(json['discount_value']?.toString() ?? '') ?? 0.0,
      image: json['image'],
        imageUrls: imageUrlsList
    );
  }


}
