import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../service_locator.dart';
import '../entities/orders_state_entity.dart';
import '../repositories/orders_repository.dart';

class GetSpecificOrderUseCase implements UseCase3<List<OrderEntity>, GetSpecificOrderParams> {
  @override
  Future<Either<Failure, List<OrderEntity>>> call(GetSpecificOrderParams params) async {
  return await sl<OrdersRepository>().getSpecificOrder(params.orderId);
  }
}

class GetSpecificOrderParams {
  final int orderId;

  GetSpecificOrderParams({required this.orderId});
}
