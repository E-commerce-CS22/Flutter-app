import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartstore/features/cart/presentation/domain/usecases/delete_cart_item_use_case.dart';
import '../../../../../service_locator.dart';
import '../../../domain/entities/wishlist_entity.dart';
import '../../../domain/usecases/delete_wishlist_item_use_case.dart';
import '../../../domain/usecases/get_wishlist_use_case.dart';


part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {

  WishlistCubit() : super(WishlistInitial());

  Future<void> getCartItems() async {
    emit(WishlistLoading());
    final result = await sl<GetWishlistItemsUseCase>().call();
    result.fold(
            (failure) => emit(WishlistError(failure.errMessage)),
            (wishlistItems) {
          print("🛒 Cart items in Cubit: $wishlistItems"); // اطبع البيانات هنا
          emit(WishlistLoaded(wishlistItems));
        }
    );
  }

  Future<void> deleteItemFromWishlist(int id) async {
    emit(WishlistLoading());
    final result = await sl<DeleteWishlistItemUseCase>().call(params: id);
    result.fold(
          (error) => emit(WishlistError(error.errMessage)),
          (_) => emit(WishlistItemDeleted(id)), // تمرير الـ itemId هنا
    );
  }
}
