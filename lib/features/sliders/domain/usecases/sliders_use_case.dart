import 'package:dartz/dartz.dart';
import 'package:smartstore/features/sliders/data/models/sliders_model.dart';
import 'package:smartstore/features/sliders/domain/repositories/sliders_repositories.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../entities/sliders_entity.dart';


class SlidersUseCase implements UseCase2<List<SlideEntity>,dynamic>{
  @override
  Future<Either<Failure, List<SlideEntity>>> call({dynamic params}) async {

    return sl<SlidersRepository>().getSlidersRepositories();

  }



}