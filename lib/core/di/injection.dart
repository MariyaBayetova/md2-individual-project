// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get_it/get_it.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:medical_appointment_app/features/appointments/domain/usecases/cancel_appointment_usecase.dart';
// import 'package:medical_appointment_app/features/appointments/domain/usecases/get_available_slots_usecase.dart';

// import '../network/dio_client.dart';
// import '../network/network_info.dart';
// // Auth
// import '../../features/auth/data/datasources/auth_remote_datasource.dart';
// import '../../features/auth/data/repositories/auth_repository_impl.dart';
// import '../../features/auth/domain/repositories/auth_repository.dart';
// import '../../features/auth/domain/usecases/login_usecase.dart';
// import '../../features/auth/domain/usecases/register_usecase.dart';
// import '../../features/auth/domain/usecases/logout_usecase.dart';
// import '../../features/auth/domain/usecases/get_auth_state_usecase.dart' hide LogoutUseCase;
// // Doctors
// import '../../features/doctors/data/datasources/doctor_remote_datasource.dart';
// import '../../features/doctors/data/repositories/doctor_repository_impl.dart';
// import '../../features/doctors/domain/repositories/doctor_repository.dart';
// import '../../features/doctors/domain/usecases/get_doctors_usecase.dart';
// // Appointments
// import '../../features/appointments/data/datasources/appointment_datasource.dart';
// import '../../features/appointments/data/repositories/appointment_repository_impl.dart';
// import '../../features/appointments/domain/repositories/appointment_repository.dart';
// import '../../features/appointments/domain/usecases/create_appointment_usecase.dart';
// import '../../features/appointments/domain/usecases/get_appointments_usecase.dart';
// // Patient card
// import '../../features/patient_card/data/datasources/patient_datasource.dart';
// import '../../features/patient_card/data/repositories/patient_repository_impl.dart';
// import '../../features/patient_card/domain/repositories/patient_repository.dart';
// import '../../features/patient_card/domain/usecases/get_patient_usecase.dart';
// import '../../features/patient_card/domain/usecases/update_patient_usecase.dart';
// import '../../features/patient_card/domain/usecases/upload_document_usecase.dart';

// final sl = GetIt.instance;

// Future<void> initDependencies() async {
//   //  External 
//   sl.registerLazySingleton<Dio>(() => DioClient.instance);
//   sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
//   sl.registerLazySingleton<FirebaseFirestore>(() {
//     final firestore = FirebaseFirestore.instance;
//     // Enable offline persistence
//     firestore.settings = const Settings(persistenceEnabled: true);
//     return firestore;
//   });
//   sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
//   sl.registerLazySingleton<Connectivity>(() => Connectivity());
//   sl.registerLazySingleton<FlutterSecureStorage>(
//     () => const FlutterSecureStorage(),
//   );

//   //  Core 
//   sl.registerLazySingleton<NetworkInfo>(
//     () => NetworkInfoImpl(sl<Connectivity>()),
//   );

//   //  Auth 
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(
//       firebaseAuth: sl(),
//       secureStorage: sl(),
//     ),
//   );
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(
//       auth: sl(),
//       firestore: sl(),
//     ),
//   );
//   sl.registerLazySingleton(() => LoginUseCase(sl()));
//   sl.registerLazySingleton(() => RegisterUseCase(sl()));
//   sl.registerLazySingleton(() => RegisterUseCase(sl()));
//   sl.registerLazySingleton(() => LogoutUseCase(sl()));
//   sl.registerLazySingleton(() => GetAuthStateUseCase(sl()));

//   //  Doctors 
//   sl.registerLazySingleton<DoctorRemoteDataSource>(
//     () => DoctorRemoteDataSourceImpl(dio: sl()),
//   );
//   sl.registerLazySingleton<DoctorRepository>(
//     () => DoctorRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
//   );
//   sl.registerLazySingleton(() => GetDoctorsUseCase(sl()));

//   //  Appointments 
//   sl.registerLazySingleton<AppointmentDataSource>(
//     () => AppointmentDataSourceImpl(firestore: sl()),
//   );
//   sl.registerLazySingleton<AppointmentRepository>(
//     () => AppointmentRepositoryImpl(dataSource: sl()),
//   );
//   sl.registerLazySingleton(() => CreateAppointmentUseCase(sl()));
//   sl.registerLazySingleton(() => GetAppointmentsUseCase(sl()));

//   //  Patient Card 
//   sl.registerLazySingleton<PatientDataSource>(
//     () => PatientDataSourceImpl(
//       firestore: sl(),
//       storage: sl(),
//     ),
//   );
//   sl.registerLazySingleton<PatientRepository>(
//     () => PatientRepositoryImpl(dataSource: sl()),
//   );
//   sl.registerLazySingleton(() => GetPatientUseCase(sl()));
//   sl.registerLazySingleton(() => UpdatePatientUseCase(sl()));
//   sl.registerLazySingleton(() => UploadDocumentUseCase(sl()));

//   sl.registerLazySingleton(() => CancelAppointmentUseCase(sl()));

//   sl.registerLazySingleton(() => GetAvailableSlotsUseCase());
// }



import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:medical_appointment_app/core/services/notification_service.dart';

import '../network/dio_client.dart';
import '../network/network_info.dart';

// Auth
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/get_auth_state_usecase.dart';

// Doctors
import '../../features/doctors/data/datasources/doctor_remote_datasource.dart';
import '../../features/doctors/data/repositories/doctor_repository_impl.dart';
import '../../features/doctors/domain/repositories/doctor_repository.dart';
import '../../features/doctors/domain/usecases/get_doctors_usecase.dart';

// Appointments
import '../../features/appointments/data/datasources/appointment_datasource.dart';
import '../../features/appointments/data/repositories/appointment_repository_impl.dart';
import '../../features/appointments/domain/repositories/appointment_repository.dart';
import '../../features/appointments/domain/usecases/create_appointment_usecase.dart';
import '../../features/appointments/domain/usecases/get_appointments_usecase.dart';
import '../../features/appointments/domain/usecases/cancel_appointment_usecase.dart';
import '../../features/appointments/domain/usecases/get_available_slots_usecase.dart';

// Patient card
import '../../features/patient_card/data/datasources/patient_datasource.dart';
import '../../features/patient_card/data/repositories/patient_repository_impl.dart';
import '../../features/patient_card/domain/repositories/patient_repository.dart';
import '../../features/patient_card/domain/usecases/get_patient_usecase.dart';
import '../../features/patient_card/domain/usecases/update_patient_usecase.dart';
import '../../features/patient_card/domain/usecases/upload_document_usecase.dart';


// Pharmacy
import '../../features/pharmacy/data/datasources/pharmacy_remote_datasource.dart';
import '../../features/pharmacy/data/repositories/pharmacy_repository_impl.dart';
import '../../features/pharmacy/domain/repositories/pharmacy_repository.dart';
import '../../features/pharmacy/domain/usecases/get_popular_drugs_usecase.dart';
import '../../features/pharmacy/domain/usecases/search_drugs_usecase.dart';
// Chat
import '../../features/chat/data/datasources/chat_datasource.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
// Emergency
import '../../features/emergency/data/repositories/emergency_repository_impl.dart';
import '../../features/emergency/domain/repositories/emergency_repository.dart';
import '../../features/emergency/domain/usecases/get_hospitals_usecase.dart';
// Articles
import '../../features/articles/data/repositories/article_repository_impl.dart';
import '../../features/articles/domain/repositories/article_repository.dart';
import '../../features/articles/domain/usecases/get_articles_usecase.dart';
// Reviews
import '../../features/reviews/data/datasources/review_datasource.dart';
import '../../features/reviews/data/repositories/review_repository_impl.dart';
import '../../features/reviews/domain/repositories/review_repository.dart';
// Reminders
import '../../features/reminders/data/repositories/reminder_repository.dart';


final sl = GetIt.instance;

Future<void> initDependencies() async {

  // External

  sl.registerLazySingleton<Dio>(() => DioClient.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() {
    final firestore = FirebaseFirestore.instance;
    firestore.settings = const Settings(persistenceEnabled: true);
    return firestore;
  });
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );


  // Core

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );
  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(),
  );

  // Auth

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      secureStorage: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      auth: sl(),
      firestore: sl(),
    ),
  );
  
  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));    
  sl.registerLazySingleton(() => GetAuthStateUseCase(sl()));


  // Doctors

  sl.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(() => GetDoctorsUseCase(sl()));


  // Appointments

  sl.registerLazySingleton<AppointmentDataSource>(
    () => AppointmentDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton(() => CreateAppointmentUseCase(sl()));
  sl.registerLazySingleton(() => GetAppointmentsUseCase(sl()));
  sl.registerLazySingleton(() => CancelAppointmentUseCase(sl()));
  sl.registerLazySingleton(() => GetAvailableSlotsUseCase());


  // Patient Card

  sl.registerLazySingleton<PatientDataSource>(
    () => PatientDataSourceImpl(
      firestore: sl(),
      storage: sl(),
    ),
  );
  sl.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton(() => GetPatientUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePatientUseCase(sl()));
  sl.registerLazySingleton(() => UploadDocumentUseCase(sl()));


  // Pharmacy
  sl.registerLazySingleton<PharmacyRemoteDataSource>(
    () => PharmacyRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<PharmacyRepository>(
    () => PharmacyRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(() => GetPopularDrugsUseCase(sl()));
  sl.registerLazySingleton(() => SearchDrugsUseCase(sl()));

  // Chat
  sl.registerLazySingleton<ChatDataSource>(
    () => ChatDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(dataSource: sl()),
  );

  // Emergency
  sl.registerLazySingleton<EmergencyRepository>(
    () => EmergencyRepositoryImpl(),
  );
  sl.registerLazySingleton(() => GetHospitalsUseCase(sl()));

  // Articles
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(),
  );
  sl.registerLazySingleton(() => GetArticlesUseCase(sl()));

  // Reviews
  sl.registerLazySingleton<ReviewDataSource>(
    () => ReviewDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(dataSource: sl()),
  );

  // Reminders
  sl.registerLazySingleton<ReminderRepository>(
    () => ReminderRepository(firestore: sl()),
  );
}
