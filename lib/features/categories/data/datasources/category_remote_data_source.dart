import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_urls.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../service_locator.dart';

abstract class CategoryApiService {
  Future<Either> getCategories();
}

class CategoryApiServiceImpl extends CategoryApiService {

  @override
  Future<Either> getCategories() async {
    try {
      var response = await sl<DioClient>().get(ApiUrls.categories);
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
