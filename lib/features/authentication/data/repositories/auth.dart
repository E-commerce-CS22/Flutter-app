import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartstore/features/authentication/data/datasources/auth_api_service.dart';
import 'package:smartstore/features/authentication/data/models/user.dart';

import '../../../../service_locator.dart';
import '../../domain/repositories/auth.dart';
import '../datasources/auth_local_service.dart';
import '../models/signin_req_params.dart';
import '../models/signup_req_params.dart';

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


  @override
  Future<Either> logout() async {
    return await sl<AuthLocalService>().logout();
  }

  @override
  Future < Either > signin(SigninReqParams signinReq) async {
    Either result = await sl < AuthApiService > ().signin(signinReq);
    return result.fold(
            (error) {
          return Left(error);
        },
            (data) async {
          Response response = data;
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('token', response.data['token']);
          return Right(response);
        }
    );
  }

  @override
  Future<Either> getUser() async {
    Either result = await sl<AuthApiService>().getUser();
    return result.fold(
            (error){
      return Left(error);
    },
        (data){
              Response response = data;
              var userModel = UserModel.fromMap(response.data);
              var userEntity = userModel.toEntity();

              return Right(userEntity);
        }
        );


  }


}

