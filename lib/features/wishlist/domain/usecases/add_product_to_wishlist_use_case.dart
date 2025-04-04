import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import 'package:smartstore/features/wishlist/domain/repositories/wishlist_repository.dart';
import '../../../../service_locator.dart';

class AddProductToWishlistUseCase extends UseCase3<void, AddProductToWishlistParams> {
  @override
  Future<Either<Failure, void>> call(AddProductToWishlistParams params) async {
    return sl<WishlistRepository>().addProductToWishlist(params.productId);
  }
}

class AddProductToWishlistParams {
  final int productId;

  AddProductToWishlistParams({required this.productId});
}
