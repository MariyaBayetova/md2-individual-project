import '../entities/appointment_entity.dart';
import '../repositories/appointment_repository.dart';

class CreateAppointmentUseCase {
  final AppointmentRepository _repository;
  CreateAppointmentUseCase(this._repository);
  Future<void> call(AppointmentEntity appointment) =>
      _repository.createAppointment(appointment);
}
