import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/product_details_entity.dart';

abstract class ProductDetailsRepository{

  Future<Either<Failure,ProductDetailsEntity>> getProductDetailsRepo(int productId);
}
