import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../../data/models/signin_req_params.dart';
import '../repositories/auth.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams> {

  @override
  Future<Either> call({SigninReqParams ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }

}