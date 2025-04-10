import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/features/search/domain/entities/search_params.dart';
import 'package:smartstore/features/search/domain/entities/search_result_entity.dart';

abstract class SearchRepository{
  Future<Either<Failure,SearchResultEntity>> searchRepository(SearchParams params);
}