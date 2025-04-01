import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service_locator.dart';
import '../../data/models/category_model.dart';
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
      print("Data Type: ${data.runtimeType}"); // طباعة نوع البيانات
      print("Data: $data"); // طباعة البيانات نفسها

      if (data is Map<String, dynamic> && data.containsKey('data')) {
        List<CategoryEntity> categories = (data['data'] as List).map((category) {
          print("Category Type: ${category.runtimeType}"); // طباعة نوع العنصر

          if (category is Map<String, dynamic>) {
            return CategoryModel.fromMap(category).toEntity();
          } else if (category is CategoryEntity) {
            return category; // لا حاجة للتحويل
          } else {
            throw Exception("Unexpected category format");
          }
        }).toList();

        emit(CategoryLoaded(categories: categories));
      } else {
        emit(LoadCategoryFailure(errorMessage: "Unexpected data format"));
      }
    });
  }

}
