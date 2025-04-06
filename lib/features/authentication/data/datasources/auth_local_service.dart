import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartstore/core/errors/failure.dart';  // تأكد من استيراد Failure

abstract class AuthLocalService {
  Future<bool> isLoggedIn();
  Future<Either<Failure, bool>> logout();
}

class AuthLocalServiceImpl extends AuthLocalService {

  @override
  Future<bool> isLoggedIn() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      print('after login token is $token');
      // إذا كانت قيمة token غير موجودة أو فارغة، فإن المستخدم ليس مسجل الدخول
      return token != null && token.isNotEmpty;
    } catch (e) {
      // في حالة حدوث أي خطأ (مثل مشاكل في SharedPreferences)
      print("Error while checking login status: $e");
      return false;
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();  // مسح البيانات
      return const Right(true);  // إرجاع النجاح إذا تم المسح بنجاح
    } catch (e) {
      // إرجاع Failure في حالة حدوث خطأ مع رسائل مناسبة
      return Left(ServerFailure(errMessage: 'حدث خطأ أثناء تسجيل الخروج'));
    }
  }

}
