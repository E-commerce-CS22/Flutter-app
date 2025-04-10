import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/features/products_by_category/domain/entities/get_products_by_category_params.dart';

import '../entities/products_by_category_entity.dart';

abstract class ProductsByCategoryRepository{
  Future<Either<Failure,ProductsByCategoryEntity>> getProductsByCategoryRepository(GetProductsByCategoryParams params);
}