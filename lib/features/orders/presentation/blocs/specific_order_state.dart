import '../../data/models/order_model.dart';
import '../../domain/entities/orders_state_entity.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderEntity> order;
  OrderLoaded(this.order);
}

class OrdersError extends OrderState {
  final String message;
  OrdersError(this.message);
}
