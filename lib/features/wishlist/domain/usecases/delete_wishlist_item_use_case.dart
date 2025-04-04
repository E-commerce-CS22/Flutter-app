import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/usecase/usecase.dart';

import '../../../../../service_locator.dart';
import '../repositories/wishlist_repository.dart';

class DeleteWishlistItemUseCase  extends UseCase2 <void , int> {
  @override
  Future<Either<Failure, void>> call({int? params}) async {
    // if (params == null){
    //   return Left(InvalidParamsFailure()); // failure في حالة عدم تمرير قيمة id
    // }
    return sl<WishlistRepository>().deleteWishlistItem(params); // تمرير id كـ params
  }

}