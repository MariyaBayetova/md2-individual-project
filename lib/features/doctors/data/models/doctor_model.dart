import '../../domain/entities/doctor_entity.dart';
import '../../../../core/constants/app_constants.dart';

class DoctorModel extends DoctorEntity {
  const DoctorModel({
    required super.id,
    required super.name,
    required super.specialty,
    required super.avatarUrl,
    required super.rating,
    required super.reviewCount,
    required super.experienceYears,
    required super.consultationFee,
    required super.about,
    super.isAvailable,
  });

  // Map from RandomUser API response
  factory DoctorModel.fromRandomUser(Map<String, dynamic> json, int index) {
    final name = json['name'] as Map<String, dynamic>;
    final fullName =
        '${name['first']} ${name['last']}';
    final picture = json['picture'] as Map<String, dynamic>;
    final specialty = AppConstants.specialties[index % AppConstants.specialties.length];

    return DoctorModel(
      id: json['login']['uuid'] as String,
      name: fullName,
      specialty: specialty,
      avatarUrl: picture['large'] as String,
      rating: 3.5 + (index % 15) * 0.1,
      reviewCount: 20 + index * 7,
      experienceYears: 2 + index % 18,
      consultationFee: 5000.0 + (index % 10) * 500,
      about:
          'Dr. $fullName is a specialist in $specialty with ${2 + index % 18} years of clinical experience. '
          'Known for a patient-centred approach and thorough consultations.',
      isAvailable: index % 5 != 0,
    );
  }
}
