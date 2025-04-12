part of 'add_to_wishlist_cubit.dart';


abstract class ProductWishlistState extends Equatable {
  const ProductWishlistState();

  @override
  List<Object> get props => [];
}

class ProductWishlistInitial extends ProductWishlistState {}

class ProductAddedToWishlist extends ProductWishlistState {
  final int productId;

  const ProductAddedToWishlist(this.productId);

  @override
  List<Object> get props => [productId];
}

class ProductRemovedFromWishlist extends ProductWishlistState {
  final int productId;

  const ProductRemovedFromWishlist(this.productId);

  @override
  List<Object> get props => [productId];
}
