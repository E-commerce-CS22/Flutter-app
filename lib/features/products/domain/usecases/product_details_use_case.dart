import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import 'package:smartstore/features/products/domain/entities/product_details_entity.dart';
import 'package:smartstore/features/products/domain/repositories/product_details_repository.dart';

import '../../../../service_locator.dart';

class GetProductDetailsUseCase implements UseCase3<ProductEntity, ProductDetailsParams>{
  @override
  Future<Either<Failure, ProductEntity>> call(ProductDetailsParams params) async {
      return await sl<ProductDetailsRepository>().getProductDetailsRepo(params.productId);
  }

}




class ProductDetailsParams {
  final int productId;

  ProductDetailsParams({required this.productId});
}