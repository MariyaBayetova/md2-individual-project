import '../../domain/entities/hospital_entity.dart';
import '../../domain/repositories/emergency_repository.dart';
import '../models/hospital_model.dart';

class EmergencyRepositoryImpl implements EmergencyRepository {
  @override
  Future<List<HospitalEntity>> getHospitals() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    return HospitalModel.getMockHospitals();
  }

  @override
  Future<List<HospitalEntity>> getEmergencyCenters() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return HospitalModel.getMockHospitals()
        .where((h) => h.hasEmergency)
        .toList();
  }
}
