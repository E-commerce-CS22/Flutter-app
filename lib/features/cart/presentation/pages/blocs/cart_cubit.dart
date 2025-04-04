import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../service_locator.dart';
import '../../../data/models/cart_model.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../domain/usecases/delete_cart_item_use_case.dart';
import '../../../domain/usecases/get_cart_use_case.dart';
import '../../../domain/usecases/update_cart_item_quantity_use_case.dart';
import 'dart:async';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {

  CartCubit() : super(CartInitial());

  Future<void> getCartItems() async {
    emit(CartLoading());
    final result = await sl<GetCartItemsUseCase>().call();
    result.fold(
            (failure) => emit(CartError(failure.errMessage)),
            (cartItems) {
          print("🛒 Cart items in Cubit: $cartItems"); // اطبع البيانات هنا
          emit(CartLoaded(cartItems));
        }
    );
  }

  Future<void> deleteItemFromCart(int id) async {
    emit(CartLoading());
    final result = await sl<DeleteCartItemUseCase>().call(params: id);
    result.fold(
          (error) => emit(CartError(error.errMessage)),
          (_) => emit(CartItemDeleted(id)), // تمرير الـ itemId هنا
    );
  }

  Timer? _debounce; // متغير لتحديد المهلة الزمنية

  void updateCartItemQuantity(int id, int quantity) {
    if (state is CartLoaded) {
      // 🔹 تحديث الكمية محليًا في واجهة المستخدم فورًا
      List<CartItemEntity> updatedCart = (state as CartLoaded).cartItems.map((item) {
        if (item.id == id) {
          return CartItemModel(
            id: item.id,
            name: item.name,
            description: item.description,
            price: item.price,
            quantity: quantity,
          ).toEntity();
        }
        return item;
      }).toList();

      emit(CartLoaded(updatedCart)); // ✅ تحديث الواجهة مباشرة

      // 🔹 إلغاء أي مؤقت سابق
      if (_debounce?.isActive ?? false) _debounce!.cancel();

      // 🔹 بدء مؤقت جديد لإرسال الطلب بعد 500ms
      _debounce = Timer(const Duration(milliseconds: 500), () async {
        final result = await sl<UpdateCartItemQuantityUseCase>().call(
          UpdateCartItemQuantityParams(id: id, quantity: quantity),
        );

        result.fold(
              (failure) => emit(CartError(failure.errMessage)),
              (_) => emit(CartLoaded(updatedCart)), // ✅ تأكيد التحديث بعد نجاح الطلب
        );
      });
    }
  }

}
