import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/orders/presentation/blocs/specific_order_state.dart';
import '../../../../service_locator.dart';
import '../../domain/usecases/specific_order_use_case.dart';


class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future<void> fetchSpecificOrder(int orderId) async {
    emit(OrderLoading());

    final result = await sl<GetSpecificOrderUseCase>().call(GetSpecificOrderParams(orderId: orderId));

    result.fold(
          (failure) => emit(OrdersError(failure.errMessage)),
          (order) => emit(OrderLoaded(order)), // هنا قمنا بتحويلها لقائمة تحتوي على عنصر واحد
    );
  }
}
