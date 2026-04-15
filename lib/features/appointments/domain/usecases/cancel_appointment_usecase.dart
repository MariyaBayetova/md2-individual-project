import '../repositories/appointment_repository.dart';

class CancelAppointmentUseCase {
  final AppointmentRepository _repo;
  CancelAppointmentUseCase(this._repo);
  Future<void> call(String id) => _repo.cancelAppointment(id);
}