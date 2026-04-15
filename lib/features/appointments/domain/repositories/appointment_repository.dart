import '../entities/appointment_entity.dart';

abstract class AppointmentRepository {
  Stream<List<AppointmentEntity>> getAppointments(String userId);
  Future<void> createAppointment(AppointmentEntity appointment);
  Future<void> cancelAppointment(String appointmentId);
}
