// import 'package:auth/core/usecase/usecase.dart';
// import 'package:auth/domain/repository/auth.dart';
// import 'package:auth/service_locator.dart';


import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/auth.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {

  @override
  Future<bool> call({dynamic params}) async {
    return sl<AuthRepository>().isLoggedIn();
  }

}