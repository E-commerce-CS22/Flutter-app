import 'package:smartstore/features/authentication/domain/usecases/get_user.dart';
import 'package:smartstore/features/cart/presentation/data/datasources/cart_remote_data_source.dart';
import 'package:smartstore/features/cart/presentation/data/repositories/cart_repository_impl.dart';
import 'package:smartstore/features/cart/presentation/domain/repositories/cart_repository.dart';
import 'package:smartstore/features/cart/presentation/domain/usecases/get_cart_use_case.dart';

import 'core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

import 'features/authentication/data/datasources/auth_api_service.dart';
import 'features/authentication/data/datasources/auth_local_service.dart';
import 'features/authentication/data/repositories/auth.dart';
import 'features/authentication/domain/repositories/auth.dart';
import 'features/authentication/domain/usecases/is_logged_in.dart';
import 'features/authentication/domain/usecases/logout.dart';
import 'features/authentication/domain/usecases/signin.dart';
import 'features/authentication/domain/usecases/signup.dart';
import 'features/cart/presentation/domain/usecases/delete_cart_item_use_case.dart';
import 'features/categories/data/datasources/category_remote_data_source.dart';
import 'features/categories/data/repositories/category_repository_impl.dart';
import 'features/categories/domain/repositories/category_repository.dart';
import 'features/categories/domain/usecases/get_categories_use_case.dart';
import 'features/categories/presentation/blocs/category_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  sl.registerSingleton<CategoryApiService>(CategoryApiServiceImpl());

  sl.registerSingleton<CartApiService>(CartApiServiceImpl());

  // Repositories

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());

  sl.registerSingleton<CartRepository>(CartRepositoryImpl());


  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());

  // sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<GetCategoriesUseCase>(GetCategoriesUseCase());

  sl.registerSingleton<GetCartItemsUseCase>(GetCartItemsUseCase());

  sl.registerSingleton<DeleteCartItemUseCase>(DeleteCartItemUseCase());




  // cubit


  // sl.registerLazySingleton<CategoryCubit>(() => CategoryCubit());
}
