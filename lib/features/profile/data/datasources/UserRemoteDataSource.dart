import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartstore/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/network/dio_client.dart';

abstract class UserRemoteDataSource {
  Future<Either<String, void>> updateProfile(Map<String, dynamic> updatedFields);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<Either<String, void>> updateProfile(Map<String, dynamic> updatedFields) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      final response = await sl<DioClient>().put(
        ApiUrls.updateUserInfo,
        data: updatedFields,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        return Right(null); // العملية نجحت
      } else {
        return Left('فشل في تعديل البيانات');
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'حدث خطأ أثناء الاتصال بالخادم');
    }
  }
}