import '../../domain/entities/appointment_entity.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_datasource.dart';
import '../models/appointment_model.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentDataSource dataSource;
  AppointmentRepositoryImpl({required this.dataSource});

  @override
  Stream<List<AppointmentEntity>> getAppointments(String userId) =>
      dataSource.getAppointments(userId);

  @override
  Future<void> createAppointment(AppointmentEntity appointment) {
    return dataSource.createAppointment(AppointmentModel(
      id: appointment.id,
      userId: appointment.userId,
      doctorId: appointment.doctorId,
      doctorName: appointment.doctorName,
      doctorSpecialty: appointment.doctorSpecialty,
      doctorAvatarUrl: appointment.doctorAvatarUrl,
      dateTime: appointment.dateTime,
      status: appointment.status,
      fee: appointment.fee,
    ));
  }

  @override
  Future<void> cancelAppointment(String appointmentId) =>
      dataSource.cancelAppointment(appointmentId);
}
