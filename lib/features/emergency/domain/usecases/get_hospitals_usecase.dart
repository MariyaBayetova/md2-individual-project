import '../entities/hospital_entity.dart';
import '../repositories/emergency_repository.dart';

class GetHospitalsUseCase {
  final EmergencyRepository repository;
  GetHospitalsUseCase(this.repository);

  Future<List<HospitalEntity>> call() => repository.getHospitals();
}
