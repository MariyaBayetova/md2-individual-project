import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/appointment_model.dart';

abstract class AppointmentDataSource {
  Stream<List<AppointmentModel>> getAppointments(String userId);
  Future<void> createAppointment(AppointmentModel appointment);
  Future<void> cancelAppointment(String appointmentId);
}

class AppointmentDataSourceImpl implements AppointmentDataSource {
  final FirebaseFirestore firestore;
  AppointmentDataSourceImpl({required this.firestore});

  CollectionReference get _col =>
      firestore.collection(AppConstants.appointmentsCollection);

  @override
  Stream<List<AppointmentModel>> getAppointments(String userId) {
    return _col
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((d) => AppointmentModel.fromFirestore(d)).toList());
  }

  @override
  Future<void> createAppointment(AppointmentModel appointment) {
    return _col.add(appointment.toJson());
  }

  @override
  Future<void> cancelAppointment(String appointmentId) {
    return _col.doc(appointmentId).update({'status': 'cancelled'});
  }
}
