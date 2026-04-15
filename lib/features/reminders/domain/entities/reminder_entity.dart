import 'package:equatable/equatable.dart';

class ReminderEntity extends Equatable {
  final String id;
  final String medicineName;
  final String dosage;
  final String frequency; // 'Once daily' | 'Twice daily' | 'Three times daily'
  final String time; // e.g. '08:00'
  final bool isActive;
  final String notes;
  final DateTime createdAt;

  const ReminderEntity({
    required this.id,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.time,
    required this.isActive,
    required this.notes,
    required this.createdAt,
  });

  ReminderEntity copyWith({bool? isActive}) => ReminderEntity(
        id: id,
        medicineName: medicineName,
        dosage: dosage,
        frequency: frequency,
        time: time,
        isActive: isActive ?? this.isActive,
        notes: notes,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [id];
}
