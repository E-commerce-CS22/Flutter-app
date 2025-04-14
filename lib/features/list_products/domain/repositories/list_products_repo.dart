import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/features/list_products/domain/entities/List_products_params.dart';

import '../entities/list_products_entity.dart';


abstract class ListProductsRepository{
  Future<Either<Failure,List<ListProductsEntity>>> getListProductsRepository(ListProductsParams params);
}