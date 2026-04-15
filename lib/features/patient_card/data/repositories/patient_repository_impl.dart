import 'dart:io';
import '../../domain/entities/patient_entity.dart';
import '../../domain/repositories/patient_repository.dart';
import '../datasources/patient_datasource.dart';
import '../models/patient_model.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientDataSource dataSource;
  PatientRepositoryImpl({required this.dataSource});

  @override
  Future<PatientEntity?> getPatient(String userId) =>
      dataSource.getPatient(userId);

  @override
  Future<void> updatePatient(PatientEntity patient) {
    return dataSource.updatePatient(PatientModel(
      id: patient.id,
      fullName: patient.fullName,
      email: patient.email,
      bloodType: patient.bloodType,
      allergies: patient.allergies,
      dateOfBirth: patient.dateOfBirth,
      gender: patient.gender,
      height: patient.height,
      weight: patient.weight,
      documentUrls: patient.documentUrls,
      avatarUrl: patient.avatarUrl,
    ));
  }

  @override
  Future<String> uploadDocument(String userId, File file) =>
      dataSource.uploadDocument(userId, file);
}
