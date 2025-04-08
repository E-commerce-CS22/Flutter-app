abstract class CancelOrderState {}

class CancelOrderInitial extends CancelOrderState {}

class CancelOrderLoading extends CancelOrderState {}

class CancelOrderSuccess extends CancelOrderState {}

class CancelOrderFailure extends CancelOrderState {
  final String message;
  CancelOrderFailure(this.message);
}
