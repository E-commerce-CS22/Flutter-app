import 'package:smartstore/features/authentication/domain/usecases/get_user.dart';
import 'package:smartstore/features/cart/domain/usecases/add_product_to_cart_use_case.dart';
import 'package:smartstore/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:smartstore/features/orders/domain/usecases/orders_use_case.dart';
import 'package:smartstore/features/profile/data/repositories/user_info_repository_impl.dart';
import 'package:smartstore/features/profile/domain/usecases/update_customer_info_use_case.dart';
import 'package:smartstore/features/wishlist/domain/usecases/add_product_to_wishlist_use_case.dart';
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
import 'features/cart/data/datasources/cart_remote_data_source.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/delete_cart_item_use_case.dart';
import 'features/cart/domain/usecases/get_cart_use_case.dart';
import 'features/cart/domain/usecases/update_cart_item_quantity_use_case.dart';
import 'features/categories/data/datasources/category_remote_data_source.dart';
import 'features/categories/data/repositories/category_repository_impl.dart';
import 'features/categories/domain/repositories/category_repository.dart';
import 'features/categories/domain/usecases/get_categories_use_case.dart';
import 'features/orders/data/datasources/orders_remote_data_source.dart';
import 'features/orders/domain/repositories/orders_repository.dart';
import 'features/orders/domain/usecases/specific_order_use_case.dart';
import 'features/profile/data/datasources/UserRemoteDataSource.dart';
import 'features/profile/domain/repositories/user_info_repository.dart';
import 'features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import 'features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'features/wishlist/domain/repositories/wishlist_repository.dart';
import 'features/wishlist/domain/usecases/delete_wishlist_item_use_case.dart';
import 'features/wishlist/domain/usecases/get_wishlist_use_case.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  sl.registerSingleton<CategoryApiService>(CategoryApiServiceImpl());

  sl.registerSingleton<CartApiService>(CartApiServiceImpl());

  sl.registerSingleton<WishlistApiService>(WishlistApiServiceImpl());

  sl.registerSingleton<UserRemoteDataSource>(UserRemoteDataSourceImpl());

  sl.registerSingleton<OrdersApiService>(OrdersApiServiceImpl());



  // Repositories

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());

  sl.registerSingleton<CartRepository>(CartRepositoryImpl());

  sl.registerSingleton<WishlistRepository>(WishlistRepositoryImpl());
  
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());

  sl.registerSingleton<OrdersRepository>(OrdersRepositoryImpl());






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



  sl.registerSingleton<GetWishlistItemsUseCase>(GetWishlistItemsUseCase());

  sl.registerSingleton<DeleteWishlistItemUseCase>(DeleteWishlistItemUseCase());


  sl.registerSingleton<UpdateCartItemQuantityUseCase>(UpdateCartItemQuantityUseCase());

  sl.registerSingleton<AddProductToCartUseCase>(AddProductToCartUseCase());

  sl.registerSingleton<AddProductToWishlistUseCase>(AddProductToWishlistUseCase());

  sl.registerSingleton<UpdateProfileUseCase>(UpdateProfileUseCase());

  sl.registerSingleton<GetOrdersUseCase>(GetOrdersUseCase());

  sl.registerSingleton<GetSpecificOrderUseCase>(GetSpecificOrderUseCase());


  // cubit


  // sl.registerLazySingleton<CategoryCubit>(() => CategoryCubit());
}
