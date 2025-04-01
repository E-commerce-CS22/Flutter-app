import 'package:dartz/dartz.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import 'package:smartstore/features/authentication/domain/repositories/auth.dart';

import '../../../../service_locator.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({dynamic params}) async {
    return sl<AuthRepository>().getUser();
  }

}