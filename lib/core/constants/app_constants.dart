abstract class AppConstants {
  // API
  static const String randomUserApiBase = 'https://randomuser.me/api';

  // Firestore collections
  static const String usersCollection = 'users';
  static const String appointmentsCollection = 'appointments';
  static const String patientCardsCollection = 'patient_cards';

  // Storage paths
  static const String documentsStoragePath = 'documents';
  static const String avatarsStoragePath = 'avatars';

  // Secure storage keys
  static const String tokenKey = 'firebase_id_token';
  static const String userIdKey = 'user_id';

  // Appointment statuses
  static const String statusConfirmed = 'confirmed';
  static const String statusPending = 'pending';
  static const String statusCompleted = 'completed';
  static const String statusCancelled = 'cancelled';

  // Specialties
  static const List<String> specialties = [
    'Therapist',
    'Cardiologist',
    'Neurologist',
    'Dentist',
    'Pediatrician',
    'Dermatologist',
  ];

  // Time slots
  static const List<String> timeSlots = [
    '09:00', '09:30', '10:00', '10:30',
    '11:00', '11:30', '12:00', '13:00',
    '13:30', '14:00', '14:30', '15:00',
    '15:30', '16:00', '16:30', '17:00',
  ];

  // Blood types
  static const List<String> bloodTypes = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-',
  ];
}
