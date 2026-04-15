import 'package:equatable/equatable.dart';

class PatientEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String? bloodType;
  final List<String> allergies;
  final String? dateOfBirth;
  final String? gender;
  final double? height;
  final double? weight;
  final List<String> documentUrls;
  final String? avatarUrl;

  const PatientEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.bloodType,
    this.allergies = const [],
    this.dateOfBirth,
    this.gender,
    this.height,
    this.weight,
    this.documentUrls = const [],
    this.avatarUrl,
  });

  PatientEntity copyWith({
    String? fullName,
    String? bloodType,
    List<String>? allergies,
    String? dateOfBirth,
    String? gender,
    double? height,
    double? weight,
    List<String>? documentUrls,
    String? avatarUrl,
  }) => PatientEntity(
    id: id,
    fullName: fullName ?? this.fullName,
    email: email,
    bloodType: bloodType ?? this.bloodType,
    allergies: allergies ?? this.allergies,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    gender: gender ?? this.gender,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    documentUrls: documentUrls ?? this.documentUrls,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );

  @override
  List<Object?> get props => [id];
}
