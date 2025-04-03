import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../service_locator.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartItemsUseCase implements UseCase2<List<CartItemEntity>, dynamic> {

  @override
  Future<Either<Failure, List<CartItemEntity>>> call({dynamic params}) async {
    return sl<CartRepository>().getCartItems();
  }
}
