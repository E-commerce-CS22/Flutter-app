import 'package:dartz/dartz.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return sl<CategoryRepository>().getCategories();

  }


}
