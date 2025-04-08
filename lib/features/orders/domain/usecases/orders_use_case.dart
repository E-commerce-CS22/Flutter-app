import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../service_locator.dart';
import '../../data/models/order_model.dart';
import '../entities/orders_state_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase implements UseCase2<List<OrderEntity>, dynamic> {
  @override
  Future<Either<Failure, List<OrderEntity>>> call({dynamic params}) async {
    return sl<OrdersRepository>().getOrders();
  }
}
