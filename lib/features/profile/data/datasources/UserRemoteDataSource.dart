import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartstore/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/entities/password_change_params.dart';

abstract class UserRemoteDataSource {
  Future<Either<String, void>> updateProfile(Map<String, dynamic> updatedFields);
  Future<Either<Failure, void>> passwordChange(PasswordChangeParams params);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<Either<String, void>> updateProfile(
      Map<String, dynamic> updatedFields) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
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
      return Left(
          e.response?.data['message'] ?? 'حدث خطأ أثناء الاتصال بالخادم');
    }
  }

  @override
  Future<Either<Failure, void>> passwordChange(PasswordChangeParams params) async {
    try {
      // الحصول على التوكن من SharedPreferences
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      // التحقق من وجود التوكن
      if (token == null) {
        return Left(Failure(errMessage: 'التوثيق غير موجود'));
      }

      // إرسال طلب PATCH لتغيير كلمة المرور
      final response = await sl<DioClient>().patch(
        ApiUrls.password,
        data: params.toJson(),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        return Right(null); // العملية نجحت
      } else {
        // في حالة أي استجابة غير 200 يتم إرسال رسالة فشل
        String message = response.data['message'] ?? 'فشل في تغيير كلمة السر';
        return Left(Failure(errMessage: message));
      }
    } on DioException catch (e) {
      // التعامل مع الاستثناءات في حال حدوث مشكلة في الاتصال بالخادم
      String errorMessage = e.response?.data['message'] ?? 'حدث خطأ أثناء الاتصال بالخادم';
      return Left(Failure(errMessage: errorMessage));
    }
  }

}
