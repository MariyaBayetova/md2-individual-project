import '../../domain/entities/appointment_entity.dart';

class GetAvailableSlotsUseCase {
  /// Возвращает список слотов со статусом доступности
  List<SlotStatus> call({
    required List<String> allSlots,
    required List<AppointmentEntity> appointments,
    required DateTime selectedDate,
  }) {
    final now = DateTime.now();

    return allSlots.map((slot) {
      final parts = slot.split(':');
      final slotTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );

      final isPast = slotTime.isBefore(now);

      final slotKey =
          '${selectedDate.year}-${selectedDate.month}-'
          '${selectedDate.day}-$slot';

      final isTaken = appointments
          .where((a) => a.status != 'cancelled')
          .map((a) =>
              '${a.dateTime.year}-${a.dateTime.month}-'
              '${a.dateTime.day}-'
              '${a.dateTime.hour}:${a.dateTime.minute.toString().padLeft(2, '0')}')
          .contains(slotKey);

      return SlotStatus(
        slot: slot,
        isPast: isPast,
        isTaken: isTaken,
      );
    }).toList();
  }
}

class SlotStatus {
  final String slot;
  final bool isPast;
  final bool isTaken;

  const SlotStatus({
    required this.slot,
    required this.isPast,
    required this.isTaken,
  });

  bool get isDisabled => isPast || isTaken;
}