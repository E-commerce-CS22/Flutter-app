import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';

import '../entities/sliders_entity.dart';  // تأكد من أن لديك هذا الموديل


abstract class SlidersRepository {
  Future<Either<Failure, List<SlideEntity>>> getSlidersRepositories();
}