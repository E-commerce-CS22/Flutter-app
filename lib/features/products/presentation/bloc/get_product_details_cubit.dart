import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/products/domain/usecases/product_details_use_case.dart';
import 'package:smartstore/features/products/presentation/bloc/get_product_details_state.dart';

import '../../../../service_locator.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int productId) async {
    emit(ProductDetailsLoading());

    final result = await sl<GetProductDetailsUseCase>()
        .call(ProductDetailsParams(productId: productId));

    result.fold(
        (failure) => emit(ProductDetailsError(failure.errMessage)),
         (productDetails) => emit(ProductDetailsLoaded(productDetails))
    );
  }
}
