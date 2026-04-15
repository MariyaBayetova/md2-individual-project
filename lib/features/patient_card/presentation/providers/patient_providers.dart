// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';
// import '../../../../core/di/injection.dart';
// import '../../domain/entities/patient_entity.dart';
// import '../../domain/usecases/get_patient_usecase.dart';
// import '../../domain/usecases/update_patient_usecase.dart';
// import '../../domain/usecases/upload_document_usecase.dart';

// final patientProvider = FutureProvider<PatientEntity?>((ref) async {
//   final uid = FirebaseAuth.instance.currentUser?.uid;
//   if (uid == null) return null;
//   return sl<GetPatientUseCase>().call(uid);
// });

// class PatientNotifier extends AsyncNotifier<PatientEntity?> {
//   @override
//   Future<PatientEntity?> build() async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) return null;
//     return sl<GetPatientUseCase>().call(uid);
//   }

// // Future<void> update(PatientEntity patient) async {
// //   state = const AsyncLoading<PatientEntity?>();
  

// //   state = await AsyncValue.guard<PatientEntity?>(() async {
// //     await sl<UpdatePatientUseCase>().call(patient);
// //     return patient; 
// //   });
// // }
// // Измените имя с update на updatePatient
// Future<void> updatePatient(PatientEntity patient) async {
//   state = const AsyncLoading<PatientEntity?>();
//   state = await AsyncValue.guard<PatientEntity?>(() async {
//     await sl<UpdatePatientUseCase>().call(patient);
//     return patient;
//   });
// }

//   Future<String?> uploadDocument(File file) async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) return null;
//     final url = await sl<UploadDocumentUseCase>().call(uid, file);
//     // Append url to patient documentUrls
//     final current = state.value;
//     if (current != null) {
//       final updated = current.copyWith(
//         documentUrls: [...current.documentUrls, url],
//       );
//       await sl<UpdatePatientUseCase>().call(updated);
//       state = AsyncData(updated);
//     }
//     return url;
//   }
// }

// final patientNotifierProvider =
//     AsyncNotifierProvider<PatientNotifier, PatientEntity?>(
//         () => PatientNotifier());

// final isUploadingDocProvider = StateProvider<bool>((ref) => false);



import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/usecases/get_patient_usecase.dart';
import '../../domain/usecases/update_patient_usecase.dart';
import '../../domain/usecases/upload_document_usecase.dart';

final patientProvider = FutureProvider<PatientEntity?>((ref) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return null;
  return sl<GetPatientUseCase>().call(uid);
});

class PatientNotifier extends AsyncNotifier<PatientEntity?> {
  @override
  Future<PatientEntity?> build() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return sl<GetPatientUseCase>().call(uid);
  }

  Future<void> updatePatient(PatientEntity patient) async {
    state = AsyncLoading();
    state = await AsyncValue.guard<PatientEntity?>(() async {
      await sl<UpdatePatientUseCase>().call(patient);
      return patient;
    });
  }

  Future<String?> uploadDocument(File file) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    final url = await sl<UploadDocumentUseCase>().call(uid, file);
    final current = state.asData?.value;
    if (current != null) {
      final updated = current.copyWith(
        documentUrls: [...current.documentUrls, url],
      );
      await sl<UpdatePatientUseCase>().call(updated);
      state = AsyncData(updated);
    }
    return url;
  }
}

final patientNotifierProvider =
    AsyncNotifierProvider<PatientNotifier, PatientEntity?>(
        () => PatientNotifier());

final isUploadingDocProvider = StateProvider<bool>((ref) => false);