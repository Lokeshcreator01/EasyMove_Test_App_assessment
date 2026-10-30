import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String? uUid;
  final String fullname;
  final String? profilePhoto;
  final String phoneNo;
  final String countryCode;
  final String email;
  final String dob;
  final String gender;
  final String role;
  final String occupation;
  final List<String> serviceInterest;
  final String howHeardAboutUs;
  final bool agreeTerms;
  final String status;
  final bool escrowKyc;
  final String? nationality;
  final String? state;
  final String? address;
  final int? pincode;
  final String? city;
  final int loyalityLevel;
  final String? token;

  const UserEntity({
    required this.id,
    this.uUid,
    required this.fullname,
    this.profilePhoto,
    required this.phoneNo,
    required this.countryCode,
    required this.email,
    required this.dob,
    required this.gender,
    required this.role,
    required this.occupation,
    required this.serviceInterest,
    required this.howHeardAboutUs,
    required this.agreeTerms,
    required this.status,
    required this.escrowKyc,
    this.nationality,
    this.state,
    this.address,
    this.pincode,
    this.city,
    required this.loyalityLevel,
    this.token,
  });

  @override
  List<Object?> get props => [
    id,
    uUid,
    fullname,
    profilePhoto,
    phoneNo,
    countryCode,
    email,
    dob,
    gender,
    role,
    occupation,
    serviceInterest,
    howHeardAboutUs,
    agreeTerms,
    status,
    escrowKyc,
    nationality,
    state,
    address,
    pincode,
    city,
    loyalityLevel,
    token,
  ];
}