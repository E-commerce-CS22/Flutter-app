import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/wishlist_entity.dart';

abstract class WishlistRepository {

  Future<Either<Failure, List<WishlistItemEntity>>> getWishlistItems();
  Future<Either<Failure, void>> deleteWishlistItem(params);
  Future<Either<Failure, void>> addProductToWishlist(int productId);

}