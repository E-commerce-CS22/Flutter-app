import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/products_by_category/domain/entities/get_products_by_category_params.dart';

import '../../../../service_locator.dart';
import '../../domain/usecases/Get_product_by_category_use_case.dart';
import 'get_product_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  ProductsByCategoryCubit() : super(ProductsByCategoryInitial());

  Future<void> fetchProductsByCategory(int categoryId, int page) async {
    emit(ProductsByCategoryLoading());

    final result = await sl<GetProductByCategoryUseCase>()
        // .call(GetProductsByCategoryParams(categoryId: categoryId, page: page, perPage: perPage));
    .call(GetProductsByCategoryParams(categoryId: categoryId, page: page));


    result.fold(
            (failure) => emit(ProductsByCategoryError(failure.errMessage)),
            (productDetails) => emit(ProductsByCategoryLoaded(productDetails))
    );
  }
}
