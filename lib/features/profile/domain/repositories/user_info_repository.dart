import 'package:dartz/dartz.dart';
import 'package:smartstore/features/profile/domain/entities/password_change_params.dart';
import '../../../../../core/errors/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> updateProfile(Map<String, dynamic> updatedFields);
  Future<Either<Failure, void>> passwordChangeRepository(PasswordChangeParams params);
}
