import 'package:dartz/dartz.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import 'package:smartstore/features/cart/domain/repositories/cart_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../service_locator.dart';

class AddProductToCartUseCase implements UseCase3<void, AddProductToCartParams> {


  @override
  Future<Either<Failure, void>> call(AddProductToCartParams params) async {
    return await sl<CartRepository>().addProductToCart(params.productId, params.quantity);
  }
}

class AddProductToCartParams {
  final int productId;
  final int quantity;

  AddProductToCartParams({required this.productId, required this.quantity});
}
