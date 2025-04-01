import '../../domain/entities/user.dart';

class UserModel {
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final String city;
  final String postalCode;

  UserModel({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.city,
    required this.postalCode,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    var data = map['data'] ?? {}; // استخراج بيانات user داخل data

    return UserModel(
      email: data['email'] as String,
      username: data['username'] as String,
      firstName: data['first_name'] as String,
      lastName: data['last_name'] as String,
      phone: data['phone'] as String,
      address: data['address'] as String,
      city: data['city'] as String,
      postalCode: data['postal_code'] as String,
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: username,
      first_name: firstName,
      last_name: lastName,
      adress: address,
      city: city,
      phone: phone,
    );
  }
}
