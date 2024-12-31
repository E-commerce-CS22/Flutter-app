import 'core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

import 'features/authentication/data/datasources/auth_api_service.dart';
import 'features/authentication/data/repositories/auth.dart';
import 'features/authentication/domain/repositories/auth.dart';
import 'features/authentication/domain/usecases/signup.dart';


final sl = GetIt.instance;

void setupServiceLocator() {

  sl.registerSingleton<DioClient>(DioClient());


  // Services

  sl.registerSingleton<AuthApiService>(
      AuthApiServiceImpl()
  );

  // Repositories


  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );



  // Usecases
  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

}
