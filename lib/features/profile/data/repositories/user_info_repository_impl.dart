import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/service_locator.dart';
import '../../domain/repositories/user_info_repository.dart';
import '../datasources/UserRemoteDataSource.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Either<Failure, void>> updateProfile(Map<String, dynamic> updatedFields) async {
    final response = await sl<UserRemoteDataSource>().updateProfile(updatedFields);

    return response.fold(
          (error) => Left(Failure(errMessage: error)),
          (_) => Right(null),
    );
  }
}
