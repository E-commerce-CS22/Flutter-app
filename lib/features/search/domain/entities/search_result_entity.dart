import 'package:smartstore/features/search/domain/entities/product_entity.dart';
import 'package:smartstore/features/search/domain/entities/search_meta_entity.dart';

class SearchResultEntity {
  final List<ProductEntity> products;
  final SearchMetaEntity meta;

  const SearchResultEntity({
    required this.products,
    required this.meta,
  });
}
