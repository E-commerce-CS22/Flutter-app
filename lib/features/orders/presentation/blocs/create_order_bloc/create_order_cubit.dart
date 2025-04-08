import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../service_locator.dart';
import '../../../domain/entities/Create_Order_Params.dart';
import '../../../domain/usecases/create_new_order_use_case.dart';
import 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());

  Future<void> createOrder(CreateOrderParams params) async {
    emit(CreateOrderLoading());

    final result = await sl<CreateOrderUseCase>().call(params);

    result.fold(
          (failure) => emit(CreateOrderError(failure.errMessage)),
          (_) => emit(CreateOrderSuccess()),
    );
  }
}
