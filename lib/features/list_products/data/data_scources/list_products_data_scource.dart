import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/network/dio_client.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/List_products_params.dart';
import '../models/list_products_model.dart';

abstract class ListProductsApiService {
  Future<Either<Failure, List<ListProductsModel>>> getProductsByCategory(ListProductsParams params);
}

class ListProductsApiServiceImpl extends ListProductsApiService {
  @override
  Future<Either<Failure, List<ListProductsModel>>> getProductsByCategory(ListProductsParams params) async {
    try {
      final response = await sl<DioClient>().get(
          "${ApiUrls.product}?per_page=${params.num}"
      );

      final data = response.data;

      // التحقق من أن البيانات هي من النوع Map
      if (data is! Map<String, dynamic>) {
        return Left(Failure(errMessage: 'بيانات غير متوقعة من السيرفر'));
      }

      // الحصول على البيانات المرتبطة بالمفتاح "data"
      final productsData = data['data'];

      // التحقق من أن البيانات داخل "data" هي من النوع List
      if (productsData is! List) {
        return Left(Failure(errMessage: 'المحتوى داخل المفتاح "data" ليس قائمة'));
      }

      // تحويل البيانات إلى قائمة من الكائنات
      List<ListProductsModel> productDetails = List<ListProductsModel>.from(
          productsData.map((item) => ListProductsModel.fromJson(item))
      );

      return Right(productDetails);  // إرجاع القائمة بنجاح

    } on DioException catch (e) {
      // التعامل مع أخطاء Dio
      String message = 'حدث خطأ أثناء تحميل الطلبات';
      if (e.response != null && e.response?.data != null) {
        message = e.response?.data['message'] ?? message;
      }
      return Left(Failure(errMessage: message));
    }
  }
}
