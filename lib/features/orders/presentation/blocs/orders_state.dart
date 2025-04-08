import '../../data/models/order_model.dart';
import '../../domain/entities/orders_state_entity.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderEntity> orders;

  OrdersLoaded(this.orders);
}

class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}


