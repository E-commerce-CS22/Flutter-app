import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../service_locator.dart';
import '../../domain/entities/password_change_params.dart';
import '../../domain/usecases/password_change_use_case.dart';
import 'password_change_state.dart';

class PasswordChangeCubit extends Cubit<PasswordChangeState> {
  PasswordChangeCubit() : super(PasswordChangeInitial());

  Future<void> changePassword(PasswordChangeParams params) async {
    emit(PasswordChangeLoading());

    final result = await sl<PasswordChangeUseCase>().call(params);

    result.fold(
          (failure) => emit(PasswordChangeError(failure.errMessage)),
          (_) => emit(PasswordChangeSuccess()),
    );
  }
}
