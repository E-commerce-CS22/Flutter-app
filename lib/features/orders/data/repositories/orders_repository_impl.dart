import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/features/orders/domain/repositories/orders_repository.dart';
import 'package:smartstore/service_locator.dart';
import '../../domain/entities/Create_Order_Params.dart';
import '../../domain/entities/orders_state_entity.dart';
import '../datasources/orders_remote_data_source.dart';

class OrdersRepositoryImpl extends OrdersRepository {
  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    try {
      final response = await sl<OrdersApiService>().getOrders();

      return response.fold(
            (failure) => Left(failure), // إذا حدث خطأ في جلب البيانات
            (orders) {
          // هنا نقوم بتحويل الـ Orders من Model إلى Entity
          final entities = orders
              .map((orderModel) => orderModel.toEntity())  // التحويل باستخدام toEntity()
              .toList();
          return Right(entities); // إرجاع الـ Entities
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString())); // إذا حدث استثناء
    }
  }



  @override
  Future<Either<Failure, List<OrderEntity>>> getSpecificOrder(int orderId) async {
    try {
      final response = await sl<OrdersApiService>().getSpecificOrder(orderId);

      return response.fold(
            (failure) => Left(failure), // إذا حدث خطأ في جلب البيانات
            (orders) {
          // هنا نقوم بتحويل الـ Orders من Model إلى Entity
          final enitiy = orders
              .map((orderModel) => orderModel.toEntity())  // التحويل باستخدام toEntity()
              .toList();
          return Right(enitiy); // إرجاع الـ Entities
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString())); // إذا حدث استثناء
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrder(int orderId) async {
      // محاولة إلغاء الطلب عبر الـ API
      return await sl<OrdersApiService>().cancelOrder(orderId);

  }

  @override
  Future<Either<Failure, bool>> createOrder(CreateOrderParams params) async{
    return await sl<OrdersApiService>().createOrder(params);
  }



}

