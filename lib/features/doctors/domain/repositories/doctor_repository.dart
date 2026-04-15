import '../entities/doctor_entity.dart';

abstract class DoctorRepository {
  Future<List<DoctorEntity>> getDoctors({String? specialty});
  Future<DoctorEntity> getDoctorById(String id);
}
