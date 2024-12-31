import 'package:dartz/dartz.dart';
import 'package:smartstore/features/authentication/data/datasources/auth_api_service.dart';

import '../../../../service_locator.dart';
import '../../domain/repositories/auth.dart';
import '../models/signup_req_Params.dart';

class AuthRepositoryImpl extends AuthRepository {


  @override
  Future<Either> signup(SignupReqParams signupReq) async{
    return sl<AuthApiService>().signup(signupReq);
  }


}