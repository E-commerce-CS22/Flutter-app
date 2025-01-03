import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartstore/features/authentication/data/datasources/auth_api_service.dart';

import '../../../../service_locator.dart';
import '../../domain/repositories/auth.dart';
import '../datasources/auth_local_service.dart';
import '../models/signup_req_Params.dart';

class AuthRepositoryImpl extends AuthRepository {


  @override
  Future<Either> signup(SignupReqParams signupReq) async{
    Either result = await sl<AuthApiService>().signup(signupReq);
    return result.fold(
            (error){
              return Left(error);
            },
            (data) async {
              Response response = data;
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              sharedPreferences.setString('token', response.data['token']);
              return right(response);
            }
    );
  }



  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }


}