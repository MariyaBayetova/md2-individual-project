import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import '../../../../core/constants/app_constants.dart';
import '../models/patient_model.dart';

abstract class PatientDataSource {
  Future<PatientModel?> getPatient(String userId);
  Future<void> updatePatient(PatientModel patient);
  Future<String> uploadDocument(String userId, File file);
}

class PatientDataSourceImpl implements PatientDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  PatientDataSourceImpl({required this.firestore, required this.storage});

  DocumentReference _doc(String uid) =>
      firestore.collection(AppConstants.patientCardsCollection).doc(uid);

  @override
  Future<PatientModel?> getPatient(String userId) async {
    final snap = await _doc(userId).get();
    if (!snap.exists) return null;
    return PatientModel.fromFirestore(snap);
  }

  @override
  Future<void> updatePatient(PatientModel patient) =>
      _doc(patient.id).set(patient.toJson(), SetOptions(merge: true));

  @override
  Future<String> uploadDocument(String userId, File file) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${p.basename(file.path)}';
    final ref = storage
        .ref()
        .child(AppConstants.documentsStoragePath)
        .child(userId)
        .child(fileName);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
