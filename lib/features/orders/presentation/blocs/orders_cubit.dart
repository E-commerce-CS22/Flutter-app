import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service_locator.dart';
import '../../domain/usecases/orders_use_case.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {


  OrdersCubit() : super(OrdersInitial());

  Future<void> fetchOrders() async {
    emit(OrdersLoading());

    final result = await sl<GetOrdersUseCase>().call();

    result.fold(
          (failure) => emit(OrdersError(failure.errMessage)),
          (orders) => emit(OrdersLoaded(orders)),
    );
  }
}
