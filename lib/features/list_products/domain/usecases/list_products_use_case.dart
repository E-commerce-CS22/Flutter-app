
import 'package:dartz/dartz.dart';
import 'package:smartstore/features/list_products/domain/entities/List_products_params.dart';
import 'package:smartstore/features/list_products/domain/entities/list_products_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/list_products_repo.dart';

class ListProductsUseCase implements UseCase3<List<ListProductsEntity>,ListProductsParams>{
  @override
  Future<Either<Failure, List<ListProductsEntity>>> call(ListProductsParams params) {

    return sl<ListProductsRepository>().getListProductsRepository(params);

  }



}