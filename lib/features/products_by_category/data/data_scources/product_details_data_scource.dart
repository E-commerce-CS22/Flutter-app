import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/network/dio_client.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/get_products_by_category_params.dart';
import '../models/ProductsByCategoryModel.dart';

abstract class ProductsByCategoryApiService {
  Future<Either<Failure, ProductsByCategoryModel>> getProductsByCategory(GetProductsByCategoryParams params);
}

class ProductsByCategoryApiServiceImpl extends ProductsByCategoryApiService {
  @override
  Future<Either<Failure, ProductsByCategoryModel>> getProductsByCategory(GetProductsByCategoryParams params) async {
    try {
      final response = await sl<DioClient>().get(
          "${ApiUrls.categories}/${params.categoryId}${ApiUrls.productsByCategory}?page=${params.page}"
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        return Left(Failure(errMessage: 'بيانات غير متوقعة من السيرفر'));
      }

      final productDetails = ProductsByCategoryModel.fromJson(data);  // تأكد من أن لديك هذا الـ model

      return Right(productDetails);  // قم بإرجاع الـ model بشكل صحيح

    } on DioException catch (e) {

      String message = 'حدث خطأ أثناء تحميل الطلبات';
      if (e.response != null && e.response?.data != null) {
        message = e.response?.data['message'] ?? message;
      }
      return Left(Failure(errMessage: message));
    }
    // catch (e) {
    //   print('❌ Error: $e');
    //   return Left(Failure(errMessage: 'حدث خطأ غير متوقع في API: $e'));
    // }
  }
}
