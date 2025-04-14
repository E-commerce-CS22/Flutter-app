import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/List_products_params.dart';
import '../../domain/entities/list_products_entity.dart';
import '../../domain/repositories/list_products_repo.dart';
import '../data_scources/list_products_data_scource.dart';

class ListProductsRepositoryImpl extends ListProductsRepository{
  @override
  Future<Either<Failure, List<ListProductsEntity>>> getListProductsRepository(ListProductsParams params) async {
    return await sl<ListProductsApiService>().getProductsByCategory(params);
  }


}