abstract class PasswordChangeState {}

class PasswordChangeInitial extends PasswordChangeState {}

class PasswordChangeLoading extends PasswordChangeState {}

class PasswordChangeSuccess extends PasswordChangeState {}

class PasswordChangeError extends PasswordChangeState {
  final String message;

  PasswordChangeError(this.message);
}
