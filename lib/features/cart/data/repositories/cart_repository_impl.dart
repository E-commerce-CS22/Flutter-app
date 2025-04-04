import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../service_locator.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_remote_data_source.dart';
import '../models/cart_model.dart';



class CartRepositoryImpl extends CartRepository {

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCartItems() async {
    try {
      final response = await sl<CartApiService>().getCartItems();
      return response.fold(
            (error) => Left(Failure(errMessage: error)),
            (data) {
          print("🐛 Raw Data from API: $data"); // ✅ تحقق من شكل البيانات بعد الإصلاح

          // ✅ الحل هنا: لا داعي لاستدعاء fromMap مجددًا
          final cartItems = data.map((item) => item.toEntity()).toList();

          return Right(cartItems);
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

// في CartRepositoryImpl
  @override
  Future<Either<Failure, void>> deleteCartItem(params) async {
    try {
      // استدعاء API لحذف العنصر من السلة
      final response = await sl<CartApiService>().deleteCartItem(params);

      // final response = await _cartApiService.deleteCartItem(params);

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
  Future<Either<Failure, void>> updateCartItemQuantity(int id, int quantity) async{

    final response = await sl<CartApiService>().updateCartItemQuantity(id, quantity);
    // return _cartApiService.updateCartItemQuantity(id, quantity).then((response) =>
        return response.fold(
              (error) => Left(Failure(errMessage: error)), // في حال الخطأ نعيد Failure
              (_) => Right(null), // في حال النجاح نعيد Right(null) بدلًا من Right فقط
        );
  }



  @override
  Future<Either<Failure, void>> addProductToCart(int productId, int quantity) async {
    final response = await sl<CartApiService>().addProductToCart(productId, quantity);
    return response.fold(
            (error) => Left(Failure(errMessage: error)),
            (_) => Right(null),
      );
  }

}
