import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../service_locator.dart';
import '../repositories/orders_repository.dart';

class CancelOrderUseCase implements UseCase3<bool, CancelOrderParams> {

  @override
  Future<Either<Failure, bool>> call(CancelOrderParams params) async {
    // استدعاء الدالة cancelOrder من الـ Repository
    return await sl<OrdersRepository>().cancelOrder(params.orderId);
  }
}

class CancelOrderParams {
  final int orderId;

  CancelOrderParams({required this.orderId});
}
