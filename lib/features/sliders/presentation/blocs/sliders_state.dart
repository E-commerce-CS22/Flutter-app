import 'package:smartstore/features/sliders/domain/entities/sliders_entity.dart';

import '../../data/models/sliders_model.dart';

abstract class SlidersState {}

class SlidersInitial extends SlidersState {}

class SlidersLoading extends SlidersState {}

class SlidersLoaded extends SlidersState {
  final List<SlideEntity> sliders;

  SlidersLoaded(this.sliders);
}

class SlidersError extends SlidersState {
  final String message;

  SlidersError(this.message);
}
