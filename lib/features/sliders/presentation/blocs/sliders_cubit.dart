import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:smartstore/features/sliders/domain/usecases/sliders_use_case.dart';
import 'package:smartstore/features/sliders/presentation/blocs/sliders_state.dart';
import '../../../../service_locator.dart';
import '../../../../core/errors/failure.dart';

class SlidersCubit extends Cubit<SlidersState> {
  SlidersCubit() : super(SlidersInitial());

  Future<void> fetchSliders() async {
    emit(SlidersLoading());

    final result = await sl<SlidersUseCase>().call(); // استدعاء الـ usecase

    result.fold(
          (failure) => emit(SlidersError(failure.errMessage)),
          (slides) => emit(SlidersLoaded(slides)),
    );
  }
}
