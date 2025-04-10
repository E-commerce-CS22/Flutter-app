import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/features/products_by_category/data/data_scources/product_details_data_scource.dart';
import 'package:smartstore/features/products_by_category/domain/entities/get_products_by_category_params.dart';
import 'package:smartstore/features/products_by_category/domain/entities/products_by_category_entity.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/products_by_category.dart';

class ProductsByCategoryRepositoryImpl extends ProductsByCategoryRepository{
  @override
  Future<Either<Failure, ProductsByCategoryEntity>> getProductsByCategoryRepository(GetProductsByCategoryParams params) async {
    return await sl<ProductsByCategoryApiService>().getProductsByCategory(params);
  }


}