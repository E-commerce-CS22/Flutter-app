import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:smartstore/core/network/dio_client.dart';
import '../../../../../core/errors/expentions.dart';
import '../../../../../service_locator.dart';
import '../models/cart_model.dart';
import '../../../../../core/errors/failure.dart';  // تأكد من استيراد Failure

abstract class CartApiService {
  Future<Either<String, List<CartItemModel>>> getCartItems();
  Future<Either<Failure, void>> deleteCartItem(int id); // إضافة المعامل id
}

class CartApiServiceImpl extends CartApiService {
  @override
  Future<Either<String, List<CartItemModel>>> getCartItems() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      var response = await sl<DioClient>().get(
        ApiUrls.cart,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      print("🐛 Raw API Response: ${response.data}");

      if (response.data is! List) {
        print("❌ Error: Response is not a List!");
        return Left("البيانات المستلمة غير صحيحة");
      }

      List<CartItemModel> cartItems = (response.data as List).map((item) {
        print("📦 Mapping Item: $item");
        return CartItemModel.fromMap(item);
      }).toList();

      print("🚀 Parsed Cart Items: $cartItems");

      return Right(cartItems);
    } on DioException catch (e) {
      print("❌ Dio Error: ${e.response?.data}");
      return Left(e.response?.data['message'] ?? 'حدث خطأ غير متوقع');
    }
  }

  @override
  Future<Either<Failure, void>> deleteCartItem(int id) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      var response = await sl<DioClient>().delete(
        '${ApiUrls.deleteCartItem}/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(null); // ✅ تم الحذف بنجاح
    } catch (e) {
      return Left(Failure(errMessage: 'حدث خطأ أثناء حذف العنصر')); // ❌ خطأ عام
    }
  }

}
