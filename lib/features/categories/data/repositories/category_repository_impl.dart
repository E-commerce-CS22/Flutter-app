import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_data_source.dart';
import '../models/category_model.dart'; // تأكد من أنك قمت بتعريف CategoryModel

class CategoryRepositoryImpl implements CategoryRepository {

  @override
  Future<Either> getCategories() async {
    Either result = await sl<CategoryApiService>().getCategories();
    return result.fold(
          (error) {
        return Left(error); // في حال حدوث خطأ
      },
          (data) {
        // البيانات المستلمة من الـ API
        Response response = data;

        // تحويل البيانات من الـ Response إلى CategoryEntity
        var categories = (response.data['data'] as List)
            .map((category) => CategoryModel.fromMap(category).toEntity())
            .toList();

        // إرجاع الـ Categories المحولة
        return Right(categories);
      },
    );
  }
}
