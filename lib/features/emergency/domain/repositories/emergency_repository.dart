import '../entities/hospital_entity.dart';

abstract class EmergencyRepository {
  Future<List<HospitalEntity>> getHospitals();
  Future<List<HospitalEntity>> getEmergencyCenters();
}
