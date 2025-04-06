import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service_locator.dart';
import '../../domain/usecases/update_customer_info_use_case.dart';
part 'user_update_state.dart';

class UserUpdateCubit extends Cubit<UserUpdateState> {
  UserUpdateCubit() : super(UserUpdateInitial());

  Future<void> updateUserProfile(UpdateProfileParams params) async {
    emit(UserUpdateLoading());

    final result = await sl<UpdateProfileUseCase>().call(params);

    result.fold(
          (failure) => emit(UserUpdateError(failure.errMessage)),
          (_) => emit(UserUpdateSuccess()),
    );
  }
}