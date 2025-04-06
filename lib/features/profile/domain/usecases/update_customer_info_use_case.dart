import 'package:dartz/dartz.dart';
import 'package:smartstore/core/errors/failure.dart';
import 'package:smartstore/core/usecase/usecase.dart';
import '../../../../../service_locator.dart';
import '../repositories/user_info_repository.dart';

class UpdateProfileUseCase extends UseCase3<void, UpdateProfileParams> {
  @override
  Future<Either<Failure, void>> call(UpdateProfileParams params) async {
    return sl<UserRepository>().updateProfile(params.toMap());
  }
}

class UpdateProfileParams {

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? username;
  final String? phone;
  final String? city;
  final String? address;

  UpdateProfileParams({
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
    this.city,
    this.address,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (firstName != null) map['first_name'] = firstName;
    if (lastName != null) map['last_name'] = lastName;
    if (email != null) map['email'] = email;
    if (username != null) map['username'] = username;
    if (phone != null) map['phone'] = phone;
    if (city != null) map['city'] = city;
    if (address != null) map['address'] = address;
    return map;
  }
}
