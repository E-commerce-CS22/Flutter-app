class SignupReqParams {
  final String first_name;
  final String last_name;
  final String email;
  final String phone;
  final String username;
  final String password;
  final String password_confirmation;
  final String address;
  final String city;
  final String postal_code;

  SignupReqParams(
      {required this.first_name,
      required this.last_name,
      required this.email,
      required this.phone,
      required this.username,
      required this.password,
      required this.password_confirmation,
      required this.address,
      required this.city,
      required this.postal_code});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'password_confirmation': password_confirmation,
      'address': address,
      'city': city,
      'postal_code': postal_code,
    };
  }

}
