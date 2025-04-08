import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/orders/domain/usecases/cancel_order_use_case.dart';
import '../../../../service_locator.dart';
import 'cancel_order_state.dart';

class CancelOrderCubit extends Cubit<CancelOrderState> {
  CancelOrderCubit() : super(CancelOrderInitial());

  Future<void> cancelOrder(int orderId) async {
    emit(CancelOrderLoading());

    final result = await sl<CancelOrderUseCase>().call(CancelOrderParams(orderId: orderId));

    result.fold(
          (failure) => emit(CancelOrderFailure(failure.errMessage)),
          (success) {
        if (success) {
          emit(CancelOrderSuccess());
        } else {
          emit(CancelOrderFailure('فشل في إلغاء الطلب'));
        }
      },
    );
  }
}
