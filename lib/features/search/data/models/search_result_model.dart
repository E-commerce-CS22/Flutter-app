import '../../domain/entities/search_result_entity.dart';
import 'product_model.dart';
import 'search_meta_model.dart';

class SearchResultModel extends SearchResultEntity {
  const SearchResultModel({
    required List<ProductModel> products,
    required SearchMetaModel meta,
  }) : super(
    products: products,
    meta: meta,
  );

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    final products = (json['data'] as List)
        .map((item) => ProductModel.fromJson(item))
        .toList();

    final meta = SearchMetaModel.fromJson(json['meta']);

    return SearchResultModel(products: products, meta: meta);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': products.map((p) => (p as ProductModel).toJson()).toList(),
      'meta': (meta as SearchMetaModel).toJson(),
    };
  }
}
