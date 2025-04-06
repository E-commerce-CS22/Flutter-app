class UserEntity {
  final String email;
  final String username;
  final String first_name;
  final String last_name;
  final String phone;
  final String city;
  final String address;

  UserEntity({
    required this.email,
    required this.username,
    required this.first_name,
    required this.last_name,
    required this.address,
    required this.city,
    required this.phone
  });
}