
import 'package:smartstore/features/products_by_category/domain/entities/products_by_category_entity.dart';

abstract class ProductsByCategoryState{}

class ProductsByCategoryInitial extends ProductsByCategoryState{}

class ProductsByCategoryLoading extends ProductsByCategoryState{}

class ProductsByCategoryLoaded extends ProductsByCategoryState{
  final ProductsByCategoryEntity products;

  ProductsByCategoryLoaded(this.products);
}


class ProductsByCategoryError extends ProductsByCategoryState{
  final String message;

  ProductsByCategoryError(this.message);

}

