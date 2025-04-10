import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import 'package:smartstore/features/search/domain/entities/search_params.dart';
import 'package:smartstore/features/search/domain/entities/search_result_entity.dart';
import '../../../../service_locator.dart';
import '../repositories/search_repository.dart';

class SearchUseCase implements UseCase3<SearchResultEntity,SearchParams>{
  @override
  Future<Either<Failure, SearchResultEntity>> call(SearchParams params) {

    return sl<SearchRepository>().searchRepository(params);

  }



}