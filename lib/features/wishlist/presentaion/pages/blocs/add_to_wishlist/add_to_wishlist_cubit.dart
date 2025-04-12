import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_to_wishlist_state.dart';

class ProductWishlistCubit extends Cubit<ProductWishlistState> {
  ProductWishlistCubit() : super(ProductWishlistInitial());

  void toggleWishlistStatus(int productId, bool isInWishlist) {
    if (isInWishlist) {
      emit(ProductRemovedFromWishlist(productId));
    } else {
      emit(ProductAddedToWishlist(productId));
    }
  }
}
