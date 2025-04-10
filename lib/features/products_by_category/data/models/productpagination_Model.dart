import 'package:smartstore/features/products_by_category/domain/entities/products_by_category_entity.dart';

import 'product_model.dart';

class ProductPaginationModel extends ProductPaginationEntity {
  ProductPaginationModel({
    required super.currentPage,
    required super.lastPage,
    required super.total,
    required super.perPage,
    required super.products,
  });

  factory ProductPaginationModel.fromJson(Map<String, dynamic> json) {
    List<ProductEntity> productList = [];

    if (json['data'] != null && json['data'] is List) {
      productList = (json['data'] as List)
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return ProductPaginationModel(
      currentPage: json['current_page'] ?? 1,
      lastPage: json['last_page'] ?? 1,
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 15,
      products: productList,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'total': total,
      'per_page': perPage,
      'data': products.map((product) => (product as ProductModel).toJson()).toList(),
    };
  }
}
