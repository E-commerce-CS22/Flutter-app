import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../service_locator.dart';
import '../repositories/cart_repository.dart';

class UpdateCartItemQuantityUseCase implements UseCase3<void, UpdateCartItemQuantityParams> {


  @override
  Future<Either<Failure, void>> call(UpdateCartItemQuantityParams params) async {
    return await sl<CartRepository>().updateCartItemQuantity(params.id, params.quantity);
    // return repository.updateCartItemQuantity(params.id, params.quantity);
  }
}

class UpdateCartItemQuantityParams {
  final int id;
  final int quantity;

  UpdateCartItemQuantityParams({required this.id, required this.quantity});
}
