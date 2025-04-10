// import 'package:dartz/dartz.dart';
// import 'package:smartstore/core/errors/failure.dart';
//
// abstract class ProductsByCategoryRepository {
//   Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(int categoryId);
// }
//
// class ProductsByCategoryRepositoryImpl implements ProductsByCategoryRepository {
//   final ProductsByCategoryApiService apiService;
//
//   ProductsByCategoryRepositoryImpl({required this.apiService});
//
//   @override
//   Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(int categoryId) async {
//     try {
//       final response = await apiService.getProductsByCategory(categoryId);
//
//       return response.fold(
//             (failure) => Left(failure), // Return failure if it exists
//             (products) => Right(products), // Return products if the response is successful
//       );
//     } catch (e) {
//       return Left(Failure(errMessage: "حدث خطأ أثناء استرجاع المنتجات: $e"));
//     }
//   }
// }
