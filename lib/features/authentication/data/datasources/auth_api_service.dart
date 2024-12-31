import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:smartstore/core/constants/api_urls.dart';
import 'package:smartstore/core/network/dio_client.dart';
import '../../../../service_locator.dart';
import '../models/signup_req_Params.dart';

abstract class AuthApiService {

  Future<Either> signup(SignupReqParams signupReq);
}


class AuthApiServiceImpl extends AuthApiService {

  @override
  Future<Either> signup(SignupReqParams signupReq) async {
    try{

      var response = await sl<DioClient>().post(
        ApiUrls.register,
        data: signupReq.toMap()
      );

      return Right(response);

    }on DioException catch(e){
      return Left(e.response!.data['message']);

    }
  }

}