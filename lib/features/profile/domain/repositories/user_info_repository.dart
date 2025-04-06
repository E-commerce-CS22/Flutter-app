import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> updateProfile(Map<String, dynamic> updatedFields);
}
