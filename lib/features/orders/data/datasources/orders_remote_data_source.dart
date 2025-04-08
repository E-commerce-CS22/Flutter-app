import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/constants/api_urls.dart';
import '../../../../../service_locator.dart';
import '../models/order_model.dart';

abstract class OrdersApiService {
  Future<Either<Failure, List<OrderEntityModel>>> getOrders();
  Future<Either<Failure, List<OrderEntityModel>>> getSpecificOrder(int orderId);
  Future<Either<Failure, bool>> cancelOrder(int orderId);



  }

class OrdersApiServiceImpl extends OrdersApiService {
  @override
  Future<Either<Failure, List<OrderEntityModel>>> getOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await sl<DioClient>().get(
        ApiUrls.orders,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      final data = response.data['data'];
      if (data is! List) {
        return Left(Failure(errMessage: 'بيانات غير متوقعة من السيرفر'));
      }

      final orders = data.map((item) => OrderEntityModel.fromJson(item)).toList().cast<OrderEntityModel>();

      return Right(orders);
    } on DioException catch (e) {
      String message = 'حدث خطأ أثناء تحميل الطلبات';
      if (e.response != null && e.response?.data != null) {
        message = e.response?.data['message'] ?? message;
      }
      return Left(Failure(errMessage: message));
    } catch (e) {
      // طباعة تفاصيل الخطأ لمساعدتنا في التحليل
      print('❌ Error: $e');
      return Left(Failure(errMessage: 'حدث خطأ غير متوقع في API: $e'));
    }
  }



  @override
  Future<Either<Failure, List<OrderEntityModel>>> getSpecificOrder(int orderId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await sl<DioClient>().get(
        "${ApiUrls.orders}/$orderId",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      final data = response.data['data'];
      if (data is! Map<String, dynamic>) {
        return Left(Failure(errMessage: 'بيانات غير متوقعة من السيرفر'));
      }

      final order = OrderEntityModel.fromJson(data);

      return Right([order]);

    } on DioException catch (e) {
      String message = 'حدث خطأ أثناء تحميل الطلبات';
      if (e.response != null && e.response?.data != null) {
        message = e.response?.data['message'] ?? message;
      }
      return Left(Failure(errMessage: message));
    } catch (e) {
      // طباعة تفاصيل الخطأ لمساعدتنا في التحليل
      print('❌ Error: $e');
      return Left(Failure(errMessage: 'حدث خطأ غير متوقع في API: $e'));
    }
  }


  @override
  Future<Either<Failure, bool>> cancelOrder(int orderId) async {
  try {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  final response = await sl<DioClient>().patch(
  "${ApiUrls.orders}/$orderId/cancel",
  options: Options(
  headers: {
  'Authorization': 'Bearer $token',
  },
  validateStatus: (status) {
  // السماح بكل الكودات لتجنب رمي الاستثناءات
  return true; // إرجاع true يسمح بالحصول على الرد بدون رمي استثناء
  }
  ),
  );

  // التحقق من حالة الاستجابة (status code)
  if (response.statusCode == 200) {
  return Right(true);  // إذا كانت الاستجابة ناجحة
  } else if (response.statusCode == 400) {
  // قراءة الرسالة من البيانات المرسلة
  String errorMessage = response.data['message'] ?? 'فشل في إلغاء الطلب';
  return Left(Failure(errMessage: errorMessage));
  } else {
  return Left(Failure(errMessage: 'فشل في إلغاء الطلب. حالة الاستجابة: ${response.statusCode}'));
  }
  } on DioException catch (e) {
  String message = 'حدث خطأ أثناء إلغاء الطلب';
  if (e.response != null && e.response?.data != null) {
  message = e.response?.data['message'] ?? message;
  }
  return Left(Failure(errMessage: message));
  } catch (e) {
  print('❌ Error: $e');
  return Left(Failure(errMessage: 'حدث خطأ غير متوقع أثناء إلغاء الطلب: $e'));
  }
  }


}
