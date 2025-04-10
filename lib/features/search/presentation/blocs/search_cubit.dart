import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartstore/features/search/presentation/blocs/search_state.dart';

import '../../../../service_locator.dart';
import '../../domain/entities/search_params.dart';
import '../../domain/usecases/search_use_case.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> fetchSearch(String key, int page) async {
    emit(SearchLoading());

    final result = await sl<SearchUseCase>()
        .call(SearchParams(key: key, page: page));

    result.fold(
            (failure) => emit(SearchError(failure.errMessage)),
            (productDetails) => emit(SearchLoaded(productDetails))
    );
  }
}
