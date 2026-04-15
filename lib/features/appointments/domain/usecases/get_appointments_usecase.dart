import '../entities/appointment_entity.dart';
import '../repositories/appointment_repository.dart';

class GetAppointmentsUseCase {
  final AppointmentRepository _repository;
  GetAppointmentsUseCase(this._repository);
  Stream<List<AppointmentEntity>> call(String userId) =>
      _repository.getAppointments(userId);
}
