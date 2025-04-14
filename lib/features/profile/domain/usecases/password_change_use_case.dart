import 'package:dartz/dartz.dart';
import 'package:smartstore/features/profile/domain/entities/password_change_params.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/user_info_repository.dart';

class PasswordChangeUseCase implements UseCase3<void, PasswordChangeParams> {
  @override
  Future<Either<Failure, void>> call(PasswordChangeParams params) {
    return sl<UserRepository>().passwordChangeRepository(params);
  }
}
