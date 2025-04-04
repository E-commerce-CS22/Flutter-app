import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:smartstore/core/network/dio_client.dart';
import '../../../../../service_locator.dart';
import '../models/wishlist_model.dart';
import '../../../../../core/errors/failure.dart';  // تأكد من استيراد Failure

abstract class WishlistApiService {
  Future<Either<String, List<WishlistItemModel>>> getWishlistItems();
  Future<Either<Failure, void>> deleteWishlistItem(int id); // إضافة المعامل id
  Future<Either<String, void>> addProductToWishlist(int productId);
}

class WishlistApiServiceImpl extends WishlistApiService {
  @override
  Future<Either<String, List<WishlistItemModel>>> getWishlistItems() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      var response = await sl<DioClient>().get(
        ApiUrls.wishlist,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      print("🐛 Raw API Response: ${response.data}");

      if (response.data is! List) {
        print("❌ Error: Response is not a List!");
        return Left("البيانات المستلمة غير صحيحة");
      }

      List<WishlistItemModel> wishlistItems = (response.data as List).map((item) {
        print("📦 Mapping Item: $item");
        return WishlistItemModel.fromMap(item);
      }).toList();

      print("🚀 Parsed Wishlist Items: $wishlistItems");

      return Right(wishlistItems);
    } on DioException catch (e) {
      print("❌ Dio Error: ${e.response?.data}");
      return Left(e.response?.data['message'] ?? 'حدث خطأ غير متوقع');
    }
  }

  @override
  Future<Either<Failure, void>> deleteWishlistItem(int id) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      await sl<DioClient>().delete(
        '${ApiUrls.wishlist}/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(null); // ✅ تم الحذف بنجاح
    } catch (e) {
      return Left(Failure(errMessage: 'حدث خطأ أثناء حذف العنصر')); // ❌ خطأ عام
    }
  }

  @override
  Future<Either<String, void>> addProductToWishlist(int productId) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');

      var response = await sl<DioClient>().post(
        '${ApiUrls.wishlist}/$productId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.data is Map && response.data.containsKey('original')) {
        return Left(response.data['original']['message']);
      }

      return Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'حدث خطأ غير متوقع');
    }
  }



}
