import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../service_locator.dart';
import '../entities/wishlist_entity.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlistItemsUseCase implements UseCase2<List<WishlistItemEntity>, dynamic> {

  @override
  Future<Either<Failure, List<WishlistItemEntity>>> call({dynamic params}) async {
    return sl<WishlistRepository>().getWishlistItems();
  }
}
