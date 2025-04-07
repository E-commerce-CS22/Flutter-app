import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/features/orders/domain/repositories/orders_repository.dart';
import 'package:smartstore/service_locator.dart';
import '../datasources/orders_remote_data_source.dart';
import '../models/order_model.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<Either<Failure, List<OrderEntityModel>>> getOrders() async {
    try {
      final response = await sl<OrdersApiService>().getOrders();

      return response.fold(
            (failure) => Left(failure),
            (orders) {
          final entities = orders.map((order) => order).toList(); // أو .toEntity() إذا فيه تحويل
          return Right(entities);
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
