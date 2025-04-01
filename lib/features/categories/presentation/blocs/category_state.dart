// import 'package:smartstore/features/authentication/domain/entities/category_entity.dart';

import '../../domain/entities/category_entity.dart';

abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;
  CategoryLoaded({required this.categories});
}

class LoadCategoryFailure extends CategoryState {
  final String errorMessage;
  LoadCategoryFailure({required this.errorMessage});
}
