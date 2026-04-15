import '../entities/doctor_entity.dart';
import '../repositories/doctor_repository.dart';

class GetDoctorsUseCase {
  final DoctorRepository _repository;
  GetDoctorsUseCase(this._repository);

  Future<List<DoctorEntity>> call({String? specialty}) =>
      _repository.getDoctors(specialty: specialty);
}
