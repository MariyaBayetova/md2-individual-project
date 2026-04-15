import '../entities/patient_entity.dart';
import '../repositories/patient_repository.dart';

class UpdatePatientUseCase {
  final PatientRepository _repo;
  UpdatePatientUseCase(this._repo);
  Future<void> call(PatientEntity patient) => _repo.updatePatient(patient);
}
