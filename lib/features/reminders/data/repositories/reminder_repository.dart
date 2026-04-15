import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/reminder_entity.dart';
import '../models/reminder_model.dart';

class ReminderRepository {
  final FirebaseFirestore firestore;
  ReminderRepository({required this.firestore});

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  CollectionReference get _col => firestore
      .collection('users')
      .doc(_uid)
      .collection('reminders');

  Stream<List<ReminderEntity>> getReminders() {
    // No orderBy — avoids needing a Firestore composite index
    return _col
        .snapshots()
        .map((s) =>
            s.docs.map((d) => ReminderModel.fromFirestore(d)).toList());
  }

  Future<void> addReminder(ReminderEntity reminder) =>
      _col.add(ReminderModel(
        id: '',
        medicineName: reminder.medicineName,
        dosage: reminder.dosage,
        frequency: reminder.frequency,
        time: reminder.time,
        isActive: reminder.isActive,
        notes: reminder.notes,
        createdAt: reminder.createdAt,
      ).toFirestore());

  Future<void> toggleReminder(String id, bool isActive) =>
      _col.doc(id).update({'isActive': isActive});

  Future<void> deleteReminder(String id) => _col.doc(id).delete();
}
