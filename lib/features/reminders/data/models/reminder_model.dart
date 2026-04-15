import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/reminder_entity.dart';

class ReminderModel extends ReminderEntity {
  const ReminderModel({
    required super.id,
    required super.medicineName,
    required super.dosage,
    required super.frequency,
    required super.time,
    required super.isActive,
    required super.notes,
    required super.createdAt,
  });

  factory ReminderModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return ReminderModel(
      id: doc.id,
      medicineName: d['medicineName'] as String? ?? '',
      dosage: d['dosage'] as String? ?? '',
      frequency: d['frequency'] as String? ?? 'Once daily',
      time: d['time'] as String? ?? '08:00',
      isActive: d['isActive'] as bool? ?? true,
      notes: d['notes'] as String? ?? '',
      createdAt:
          (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'medicineName': medicineName,
        'dosage': dosage,
        'frequency': frequency,
        'time': time,
        'isActive': isActive,
        'notes': notes,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
