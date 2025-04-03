import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartstore/features/cart/presentation/domain/usecases/delete_cart_item_use_case.dart';
import '../../../../../service_locator.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/usecases/get_cart_use_case.dart';

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
}
