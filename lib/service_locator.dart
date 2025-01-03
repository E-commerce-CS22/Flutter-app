import 'core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

import 'features/authentication/data/datasources/auth_api_service.dart';
import 'features/authentication/data/datasources/auth_local_service.dart';
import 'features/authentication/data/repositories/auth.dart';
import 'features/authentication/domain/repositories/auth.dart';
import 'features/authentication/domain/usecases/is_logged_in.dart';
import 'features/authentication/domain/usecases/logout.dart';
import 'features/authentication/domain/usecases/signup.dart';


final sl = GetIt.instance;

void setupServiceLocator() {

  sl.registerSingleton<DioClient>(DioClient());


  // Services

  sl.registerSingleton<AuthApiService>(
      AuthApiServiceImpl()
  );

  sl.registerSingleton<AuthLocalService>(
      AuthLocalServiceImpl()
  );

  // Repositories


  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );



  // Usecases
  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );


  sl.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase()
  );

  // sl.registerSingleton<GetUserUseCase>(
  //     GetUserUseCase()
  // );

  sl.registerSingleton<LogoutUseCase>(
      LogoutUseCase()
  );

  // sl.registerSingleton<SigninUseCase>(
  //     SigninUseCase()
  // );

}
