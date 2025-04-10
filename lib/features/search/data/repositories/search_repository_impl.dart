import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/features/search/domain/entities/search_result_entity.dart';

import '../../../../service_locator.dart';
import '../../domain/entities/search_params.dart';
import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_data_scource.dart';

class SearchRepositoryImpl extends SearchRepository{
  @override
  Future<Either<Failure, SearchResultEntity>> searchRepository(SearchParams params) async {
    return await sl<SearchApiService>().search(params);
  }


}