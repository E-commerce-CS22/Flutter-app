import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../service_locator.dart';
import '../../data/models/order_model.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase implements UseCase2<List<OrderEntityModel>, dynamic> {
  @override
  Future<Either<Failure, List<OrderEntityModel>>> call({dynamic params}) async {
    return sl<OrdersRepository>().getOrders();
  }
}
