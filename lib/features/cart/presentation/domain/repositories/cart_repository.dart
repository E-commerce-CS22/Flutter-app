import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';

abstract class CartRepository {

  Future<Either<Failure, List<CartItemEntity>>> getCartItems();
  Future<Either<Failure, void>> deleteCartItem(params);

}