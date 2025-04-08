import 'package:dartz/dartz.dart';
import 'package:smartstore/features/orders/domain/entities/Create_Order_Params.dart';
import 'package:smartstore/features/orders/domain/repositories/orders_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';

class CreateOrderUseCase implements UseCase3<void, CreateOrderParams> {
  @override
  Future<Either<Failure, void>> call(CreateOrderParams params) {
    return sl<OrdersRepository>().createOrder(params);
  }
}
