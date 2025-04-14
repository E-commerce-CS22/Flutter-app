import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/network/dio_client.dart';
import '../../../../service_locator.dart';
import '../models/product_details_model.dart';

abstract class ProductsApiService {
  Future<Either<Failure, ProductModel>> getProductDetails(int productId);

}


class ProductsApiServiceImpl extends ProductsApiService{
  @override
  Future<Either<Failure, ProductModel>> getProductDetails(int productId) async {

    try{
      final response = await sl<DioClient>().get(
        "${ApiUrls.product}/$productId",
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        return Left(Failure(errMessage: 'بيانات غير متوقعة من السيرفر'));
      }
      final productDetails = ProductModel.fromJson(data);

      return Right(productDetails);

    }on DioException catch(e){

      String message = 'حدث خطأ أثناء تحميل الطلبات';
      if (e.response != null && e.response?.data != null) {
        message = e.response?.data['message'] ?? message;
      }
      return Left(Failure(errMessage: message));
    }
    // catch (e) {
    //   // طباعة تفاصيل الخطأ لمساعدتنا في التحليل
    //   print('❌ Error: $e');
    //   return Left(Failure(errMessage: 'حدث خطأ غير متوقع في API: $e'));
    // }

  }



}