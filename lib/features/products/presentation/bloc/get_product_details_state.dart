import 'package:smartstore/features/products/domain/entities/product_details_entity.dart';

abstract class ProductDetailsState{}

class ProductDetailsInitial extends ProductDetailsState{}

class ProductDetailsLoading extends ProductDetailsState{}

class ProductDetailsLoaded extends ProductDetailsState{
  final ProductDetailsEntity product;

  ProductDetailsLoaded(this.product);
}


class ProductDetailsError extends ProductDetailsState{
  final String message;

  ProductDetailsError(this.message);

}

