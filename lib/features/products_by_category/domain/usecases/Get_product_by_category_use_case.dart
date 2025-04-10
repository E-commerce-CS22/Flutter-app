import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import 'package:smartstore/features/products_by_category/domain/entities/get_products_by_category_params.dart';
import 'package:smartstore/features/products_by_category/domain/entities/products_by_category_entity.dart';
import 'package:smartstore/features/products_by_category/domain/repositories/products_by_category.dart';

import '../../../../service_locator.dart';

class GetProductByCategoryUseCase implements UseCase3<ProductsByCategoryEntity,GetProductsByCategoryParams>{
  @override
  Future<Either<Failure, ProductsByCategoryEntity>> call(GetProductsByCategoryParams params) {

    return sl<ProductsByCategoryRepository>().getProductsByCategoryRepository(params);

  }



}