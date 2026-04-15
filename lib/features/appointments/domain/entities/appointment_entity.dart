import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final String userId;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorAvatarUrl;
  final DateTime dateTime;
  final String status;
  final double fee;

  const AppointmentEntity({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorAvatarUrl,
    required this.dateTime,
    required this.status,
    required this.fee,
  });

  bool get isUpcoming => dateTime.isAfter(DateTime.now());

  @override
  List<Object?> get props => [id];
}
