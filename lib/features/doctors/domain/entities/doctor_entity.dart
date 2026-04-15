import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String id;
  final String name;
  final String specialty;
  final String avatarUrl;
  final double rating;
  final int reviewCount;
  final int experienceYears;
  final double consultationFee;
  final String about;
  final bool isAvailable;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.specialty,
    required this.avatarUrl,
    required this.rating,
    required this.reviewCount,
    required this.experienceYears,
    required this.consultationFee,
    required this.about,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [id, name, specialty];
}
