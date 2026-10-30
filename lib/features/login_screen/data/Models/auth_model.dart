import '../../domain/entities/auth_entity.dart';


class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.uUid,
    required super.fullname,
    super.profilePhoto,
    required super.phoneNo,
    required super.countryCode,
    required super.email,
    required super.dob,
    required super.gender,
    required super.role,
    required super.occupation,
    required super.serviceInterest,
    required super.howHeardAboutUs,
    required super.agreeTerms,
    required super.status,
    required super.escrowKyc,
    super.nationality,
    super.state,
    super.address,
    super.pincode,
    super.city,
    required super.loyalityLevel,
    super.token,
  });

  /// Expects the full root JSON response: { "status": true, "user": {...}, "token": "..." }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userMap = json['user'] is Map<String, dynamic>
        ? json['user'] as Map<String, dynamic>
        : json;

    return UserModel(
      id: userMap['id'] is int
          ? userMap['id']
          : int.tryParse(userMap['id']?.toString() ?? '0') ?? 0,
      uUid: userMap['u_uid']?.toString(),
      fullname: userMap['fullname'] ?? '',
      profilePhoto: userMap['profile_photo']?.toString(),
      phoneNo: userMap['phone_no']?.toString() ?? '',
      countryCode: userMap['country_code']?.toString() ?? '',
      email: userMap['email'] ?? '',
      dob: userMap['dob'] ?? '',
      gender: userMap['gender'] ?? '',
      role: userMap['role'] ?? 'user',
      occupation: userMap['occupation'] ?? '',
      serviceInterest: userMap['service_interest'] != null
          ? List<String>.from(
        (userMap['service_interest'] as List).map((e) => e.toString()),
      )
          : [],
      howHeardAboutUs: userMap['how_heard_about_us'] ?? '',
      agreeTerms: userMap['agree_terms'] == 1 || userMap['agree_terms'] == true,
      status: userMap['status']?.toString() ?? 'active',
      escrowKyc: userMap['escrow_kyc'] == 1 || userMap['escrow_kyc'] == true,
      nationality: userMap['nationality']?.toString(),
      state: userMap['state']?.toString(),
      address: userMap['address']?.toString(),
      pincode: userMap['pincode'] is int
          ? userMap['pincode']
          : int.tryParse(userMap['pincode']?.toString() ?? ''),
      city: userMap['city']?.toString(),
      loyalityLevel: userMap['loyalityLevel'] is int
          ? userMap['loyalityLevel']
          : int.tryParse(userMap['loyalityLevel']?.toString() ?? '0') ?? 0,
      token: json['token']?.toString() ?? userMap['token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'u_uid': uUid,
      'fullname': fullname,
      'profile_photo': profilePhoto,
      'phone_no': phoneNo,
      'country_code': countryCode,
      'email': email,
      'dob': dob,
      'gender': gender,
      'role': role,
      'occupation': occupation,
      'service_interest': serviceInterest,
      'how_heard_about_us': howHeardAboutUs,
      'agree_terms': agreeTerms ? 1 : 0,
      'status': status,
      'escrow_kyc': escrowKyc ? 1 : 0,
      'nationality': nationality,
      'state': state,
      'address': address,
      'pincode': pincode,
      'city': city,
      'loyalityLevel': loyalityLevel,
      if (token != null) 'token': token,
    };
  }
}