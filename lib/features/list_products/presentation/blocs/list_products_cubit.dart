import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service_locator.dart';
import '../../domain/entities/List_products_params.dart';
import '../../domain/usecases/list_products_use_case.dart';
import 'list_products_state.dart';

class ListProductsCubit extends Cubit<ListProductsState> {
  ListProductsCubit() : super(ListProductsInitial());

  Future<void> fetchListProducts(int num) async {
    emit(ListProductsLoading());

    final result = await sl<ListProductsUseCase>()
        .call(ListProductsParams(num: num));

    result.fold(
          (failure) => emit(ListProductsError(failure.errMessage)),
          (productDetails) => emit(ListProductsLoaded(productDetails)),
    );
  }
}
