class PasswordChangeParams {
  final String currentPassword;
  final String password;
  final String passwordConfirm;

  PasswordChangeParams({
    required this.currentPassword,
    required this.password,
    required this.passwordConfirm,
  });

  // دالة لتحويل OrderItemParam إلى Map<String, dynamic>
  Map<String, dynamic> toJson() => {
    'current_password': currentPassword,
    'password': password,
    'password_confirmation': passwordConfirm,
  };
}
