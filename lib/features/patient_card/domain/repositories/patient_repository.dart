import 'dart:io';
import '../entities/patient_entity.dart';

abstract class PatientRepository {
  Future<PatientEntity?> getPatient(String userId);
  Future<void> updatePatient(PatientEntity patient);
  Future<String> uploadDocument(String userId, File file);
}
