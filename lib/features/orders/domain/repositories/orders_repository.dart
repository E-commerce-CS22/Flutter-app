import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/order_model.dart';
import '../entities/orders_state_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, List<OrderEntity>>> getSpecificOrder(int orderId);

}