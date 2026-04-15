import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:medical_appointment_app/core/constants/app_constants.dart';
import 'package:medical_appointment_app/features/appointments/domain/usecases/get_available_slots_usecase.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/usecases/get_appointments_usecase.dart';
import '../../domain/usecases/create_appointment_usecase.dart';

// Real-time appointments stream
final appointmentsStreamProvider =
    StreamProvider<List<AppointmentEntity>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return const Stream.empty();
  return sl<GetAppointmentsUseCase>().call(user.uid);
});

final upcomingAppointmentsProvider =
    Provider<AsyncValue<List<AppointmentEntity>>>((ref) {
  return ref.watch(appointmentsStreamProvider).whenData(
        (list) => list.where((a) => a.isUpcoming).toList(),
      );
});

final pastAppointmentsProvider =
    Provider<AsyncValue<List<AppointmentEntity>>>((ref) {
  return ref.watch(appointmentsStreamProvider).whenData(
        (list) => list.where((a) => !a.isUpcoming).toList(),
      );
});

final nextAppointmentProvider =
    Provider<AsyncValue<AppointmentEntity?>>((ref) {
  return ref.watch(upcomingAppointmentsProvider).whenData(
        (list) => list.isEmpty ? null : list.first,
      );
});

// Booking state
class BookingNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> book(AppointmentEntity appointment) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => sl<CreateAppointmentUseCase>().call(appointment),
    );
  }
}

final bookingProvider =
    AsyncNotifierProvider<BookingNotifier, void>(() => BookingNotifier());

// Selected booking date/time
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final selectedTimeSlotProvider = StateProvider<String?>((ref) => null);


final bookedSlotsProvider =
    FutureProvider.family<List<String>, String>((ref, doctorId) async {
  final appointments = await ref.watch(appointmentsStreamProvider.future);
  return appointments
      .where((a) => a.status != 'cancelled') // только не отменённые
      .map((a) =>
          '${a.dateTime.year}-${a.dateTime.month}-${a.dateTime.day}-'
          '${a.dateTime.hour}:${a.dateTime.minute.toString().padLeft(2, '0')}')
      .toList();
});


final availableSlotsProvider =
    Provider.family<List<SlotStatus>, DateTime>((ref, selectedDate) {
  final appointments =
      ref.watch(appointmentsStreamProvider).asData?.value ?? [];
  return sl<GetAvailableSlotsUseCase>().call(
    allSlots: AppConstants.timeSlots,
    appointments: appointments,
    selectedDate: selectedDate,
  );
});

// Текущий userId через провайдер
final currentUserIdProvider = Provider<String>((ref) {
  return FirebaseAuth.instance.currentUser?.uid ?? '';
});