import 'package:dartz/dartz.dart';
import 'package:smartstore/features/products/data/datascources/product_details_data_scource.dart';
import 'package:smartstore/features/products/domain/entities/product_details_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/product_details_repository.dart';

class ProductDetailsRepositoryImpl extends ProductDetailsRepository{
  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetailsRepo(int productId) async{

    return await sl<ProductsApiService>().getProductDetails(productId);
  }

}
