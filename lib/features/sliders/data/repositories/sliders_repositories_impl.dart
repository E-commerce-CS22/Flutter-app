import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import '../../../../service_locator.dart'; // تأكد من إضافة الخدمة في Service Locator
import '../../domain/entities/sliders_entity.dart';
import '../../domain/repositories/sliders_repositories.dart';
import '../data_scource/sliders_data_scource.dart';
import '../models/sliders_model.dart'; // مسار الـ API الخاص بالـ Sliders

class SlidersRepositoryImpl extends SlidersRepository {
  @override
  Future<Either<Failure, List<SlideEntity>>> getSlidersRepositories() async {
    return await sl<SlidersApiService>().getSliders();
  }

}
