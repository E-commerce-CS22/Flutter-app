import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/order_model.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderEntityModel>>> getOrders();
}