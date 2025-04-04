part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> cartItems;

  const CartLoaded(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}

class CartItemDeleted extends CartState {
  final int itemId;
  const CartItemDeleted(this.itemId);
}


class CartItemUpdatedState extends CartState {
  final int itemId;
  final int newQuantity;

  CartItemUpdatedState({required this.itemId, required this.newQuantity});
}