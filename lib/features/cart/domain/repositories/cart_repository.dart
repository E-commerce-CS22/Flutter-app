import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';

abstract class CartRepository {

  Future<Either<Failure, List<CartItemEntity>>> getCartItems();
  Future<Either<Failure, void>> deleteCartItem(params);
  Future<Either<Failure, void>> updateCartItemQuantity(int id, int quantity);
  Future<Either<Failure, void>> addProductToCart(int id, int quantity);



}