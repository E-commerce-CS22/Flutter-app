import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartstore/features/search/data/models/search_result_model.dart';
import 'package:smartstore/features/search/domain/entities/search_params.dart';
import '../../../../core/constants/api_urls.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../service_locator.dart';

abstract class SearchApiService {
  Future<Either<Failure, SearchResultModel>> search(SearchParams params);
}

class SearchApiServiceImpl extends SearchApiService {
  @override
  Future<Either<Failure, SearchResultModel>> search(SearchParams params) async {
    try {
      final response = await sl<DioClient>().get(
          "${ApiUrls.search}/${params.key}?page=${params.page}"
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        return Left(Failure(errMessage: 'بيانات غير متوقعة من السيرفر'));
      }

      final productDetails = SearchResultModel.fromJson(data);  // تأكد من أن لديك هذا الـ model

      return Right(productDetails);  // قم بإرجاع الـ model بشكل صحيح

    } on DioException catch (e) {

      String message = 'حدث خطأ أثناء تحميل الطلبات';
      if (e.response != null && e.response?.data != null) {
        message = e.response?.data['message'] ?? message;
      }
      return Left(Failure(errMessage: message));
    }
    catch (e) {
      print('❌ Error: $e');
      return Left(Failure(errMessage: 'حدث خطأ غير متوقع في API: $e'));
    }
  }
}