import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/auth.dart';

class LogoutUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().logout();
  }

}