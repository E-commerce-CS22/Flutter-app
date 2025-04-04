import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../service_locator.dart';
import '../../domain/entities/wishlist_entity.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_remote_data_source.dart';
import '../models/wishlist_model.dart';



class WishlistRepositoryImpl extends WishlistRepository {

  @override
  Future<Either<Failure, List<WishlistItemEntity>>> getWishlistItems() async {
    try {
      final response = await sl<WishlistApiService>().getWishlistItems();
      return response.fold(
            (error) => Left(Failure(errMessage: error)),
            (data) {
          print("🐛 Raw Data from API: $data"); // ✅ تحقق من شكل البيانات بعد الإصلاح

          // ✅ الحل هنا: لا داعي لاستدعاء fromMap مجددًا
          final wishlistItems = data.map((item) => item.toEntity()).toList();

          return Right(wishlistItems);
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

// في WishlistRepositoryImpl
  @override
  Future<Either<Failure, void>> deleteWishlistItem(params) async {
    try {
      // استدعاء API لحذف العنصر من السلة
      // final response = await _wishlistApiService.deleteWishlistItem(params);
      final response = await sl<WishlistApiService>().deleteWishlistItem(params);
      // تحقق من النتيجة
      return response.fold(
            (error) {
              return Left(error as Failure);
          },
            (_) => Right(null), // في حال النجاح لا حاجة لإرجاع بيانات
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString())); // ✅ إصلاح الخطأ هنا أيضًا
    }
  }


  @override
  Future<Either<Failure, void>> addProductToWishlist(int productId) async {
    // final response = await _wishlistApiService.addProductToWishlist(productId);
    final response = await sl<WishlistApiService>().addProductToWishlist(productId);
    return response.fold(
          (error) => Left(Failure(errMessage: error)),
          (_) => Right(null),
    );
  }

}
