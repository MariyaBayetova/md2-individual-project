import '../entities/patient_entity.dart';
import '../repositories/patient_repository.dart';

class GetPatientUseCase {
  final PatientRepository _repo;
  GetPatientUseCase(this._repo);
  Future<PatientEntity?> call(String userId) => _repo.getPatient(userId);
}
