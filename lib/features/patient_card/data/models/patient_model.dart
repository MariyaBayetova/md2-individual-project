import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/patient_entity.dart';

class PatientModel extends PatientEntity {
  const PatientModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.bloodType,
    super.allergies,
    super.dateOfBirth,
    super.gender,
    super.height,
    super.weight,
    super.documentUrls,
    super.avatarUrl,
  });

  factory PatientModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return PatientModel(
      id: doc.id,
      fullName: d['fullName'] as String? ?? '',
      email: d['email'] as String? ?? '',
      bloodType: d['bloodType'] as String?,
      allergies: List<String>.from(d['allergies'] as List? ?? []),
      dateOfBirth: d['dateOfBirth'] as String?,
      gender: d['gender'] as String?,
      height: (d['height'] as num?)?.toDouble(),
      weight: (d['weight'] as num?)?.toDouble(),
      documentUrls: List<String>.from(d['documentUrls'] as List? ?? []),
      avatarUrl: d['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
        'bloodType': bloodType,
        'allergies': allergies,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'height': height,
        'weight': weight,
        'documentUrls': documentUrls,
        'avatarUrl': avatarUrl,
      };
}
