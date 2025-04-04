import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:smartstore/core/network/dio_client.dart';
import '../../../../../service_locator.dart';
import '../models/cart_model.dart';
import '../../../../../core/errors/failure.dart';  // تأكد من استيراد Failure

abstract class CartApiService {
  Future<Either<String, List<CartItemModel>>> getCartItems();
  Future<Either<Failure, void>> deleteCartItem(int id); // إضافة المعامل id
  Future<Either<String, void>> updateCartItemQuantity(int id, int quantity);
  Future<Either<String, void>> addProductToCart(int productId, int quantity);
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

      await sl<DioClient>().delete(
        '${ApiUrls.cart}/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(null); // ✅ تم الحذف بنجاح
    } catch (e) {
      return Left(Failure(errMessage: 'حدث خطأ أثناء حذف العنصر')); // ❌ خطأ عام
    }
  }

  Future<Either<String, void>> updateCartItemQuantity(int id, int quantity) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      var response = await sl<DioClient>().patch(
        '${ApiUrls.cart}/$id',
        data: {"quantity": quantity},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // ✅ التحقق من الاستجابة إذا كانت `1` نجاح أو `0` فشل
      if (response.data == 1) {
        return Right(null); // ✅ نجاح
      } else {
        return Left('فشل في تعديل الكمية'); // ❌ فشل
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'حدث خطأ غير متوقع');
    }
  }


  // add product to cart

  @override
  Future<Either<String, void>> addProductToCart(int productId, int quantity) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      var response = await sl<DioClient>().post(
        ApiUrls.cart,
        data: {"product_id": productId, "quantity": quantity},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // ✅ التحقق مما إذا كانت الاستجابة تحتوي على "message" (أي خطأ)
      if (response.data is Map<String, dynamic> && response.data.containsKey('original')) {
        return Left(response.data['original']['message'] ?? 'حدث خطأ غير متوقع');
      }

      return Right(null); // ✅ نجاح العملية
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'حدث خطأ غير متوقع');
    }
  }


}
