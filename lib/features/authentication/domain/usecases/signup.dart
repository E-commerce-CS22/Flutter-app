import 'package:dartz/dartz.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import 'package:smartstore/features/authentication/data/models/signup_req_params.dart';
import 'package:smartstore/features/authentication/domain/repositories/auth.dart';

import '../../../../service_locator.dart';

class SignupUseCase implements UseCase<Either, SignupReqParams> {

  @override
  Future<Either> call({SignupReqParams ? params}) async {
    return sl<AuthRepository>().signup(params!);
  }

}