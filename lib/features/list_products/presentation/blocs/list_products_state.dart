
import 'package:smartstore/features/list_products/domain/entities/list_products_entity.dart';

abstract class ListProductsState {}

class ListProductsInitial extends ListProductsState {}

class ListProductsLoading extends ListProductsState {}

class ListProductsLoaded extends ListProductsState {
  final List<ListProductsEntity> products;

  ListProductsLoaded(this.products);
}

class ListProductsError extends ListProductsState {
  final String message;

  ListProductsError(this.message);
}
