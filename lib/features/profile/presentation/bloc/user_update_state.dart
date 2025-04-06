part of 'user_update_cubit.dart';

abstract class UserUpdateState extends Equatable {
  const UserUpdateState();

  @override
  List<Object?> get props => [];
}

class UserUpdateInitial extends UserUpdateState {}

class UserUpdateLoading extends UserUpdateState {}

class UserUpdateSuccess extends UserUpdateState {}

class UserUpdateError extends UserUpdateState {
  final String errMessage;

  const UserUpdateError(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
