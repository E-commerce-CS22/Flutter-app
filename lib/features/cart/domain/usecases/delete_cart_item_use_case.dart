import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/usecase/usecase.dart';
// import 'package:smartstore/features/cart/presentation/domain/repositories/cart_repository.dart';

import '../../../../../service_locator.dart';
import '../repositories/cart_repository.dart';

class DeleteCartItemUseCase  extends UseCase2 <void , int> {
  @override
  Future<Either<Failure, void>> call({int? params}) async {
    // if (params == null){
    //   return Left(InvalidParamsFailure()); // failure في حالة عدم تمرير قيمة id
    // }
    return sl<CartRepository>().deleteCartItem(params); // تمرير id كـ params
  }

}