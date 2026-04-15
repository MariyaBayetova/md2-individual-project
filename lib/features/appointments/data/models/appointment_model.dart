import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel({
    required super.id,
    required super.userId,
    required super.doctorId,
    required super.doctorName,
    required super.doctorSpecialty,
    required super.doctorAvatarUrl,
    required super.dateTime,
    required super.status,
    required super.fee,
  });

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppointmentModel(
      id: doc.id,
      userId: data['userId'] as String,
      doctorId: data['doctorId'] as String,
      doctorName: data['doctorName'] as String,
      doctorSpecialty: data['doctorSpecialty'] as String,
      doctorAvatarUrl: data['doctorAvatarUrl'] as String? ?? '',
      dateTime: (data['timestamp'] as Timestamp).toDate(),
      status: data['status'] as String,
      fee: (data['fee'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'doctorId': doctorId,
        'doctorName': doctorName,
        'doctorSpecialty': doctorSpecialty,
        'doctorAvatarUrl': doctorAvatarUrl,
        'timestamp': Timestamp.fromDate(dateTime),
        'status': status,
        'fee': fee,
      };
}
