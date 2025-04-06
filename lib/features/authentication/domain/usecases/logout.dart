import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/auth.dart';

class LogoutUseCase implements UseCase2<bool, dynamic> {

  @override
  Future<Either<Failure , bool>> call({dynamic params}) async {
    // استدعاء الـ repository
    return await sl<AuthRepository>().logout();
  }

}
