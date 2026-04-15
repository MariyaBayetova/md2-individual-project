import 'dart:io';
import '../repositories/patient_repository.dart';

class UploadDocumentUseCase {
  final PatientRepository _repo;
  UploadDocumentUseCase(this._repo);
  Future<String> call(String userId, File file) =>
      _repo.uploadDocument(userId, file);
}
