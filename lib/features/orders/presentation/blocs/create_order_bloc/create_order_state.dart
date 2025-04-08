// create_order_state.dart
abstract class CreateOrderState {}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderLoading extends CreateOrderState {}

class CreateOrderSuccess extends CreateOrderState {}

class CreateOrderError extends CreateOrderState {
  final String message;

  CreateOrderError(this.message);
}
