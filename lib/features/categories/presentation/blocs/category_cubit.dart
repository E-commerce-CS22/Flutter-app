import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_categories_use_case.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryLoading());

  void displayCategories() async {
    var result = await sl<GetCategoriesUseCase>().call();
    result.fold((error) {
      emit(LoadCategoryFailure(errorMessage: error));
    }, (data) {
      // print("Data Type: ${data.runtimeType}"); // طباعة نوع البيانات
      // print("Data: $data"); // طباعة البيانات نفسها

      if (data is List<CategoryEntity>) {
        emit(CategoryLoaded(categories: data)); // لا داعي للتحويل
      } else {
        emit(LoadCategoryFailure(errorMessage: "Unexpected data format"));
      }
    });
  }


}
