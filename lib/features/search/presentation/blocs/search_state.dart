import 'package:smartstore/features/search/domain/entities/search_result_entity.dart';

abstract class SearchState{}

class SearchInitial extends SearchState{}

class SearchLoading extends SearchState{}

class SearchLoaded extends SearchState{
  final SearchResultEntity products;

  SearchLoaded(this.products);
}


class SearchError extends SearchState{
  final String message;

  SearchError(this.message);

}

