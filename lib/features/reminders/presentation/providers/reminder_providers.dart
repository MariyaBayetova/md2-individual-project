import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../data/repositories/reminder_repository.dart';

final remindersStreamProvider =
    StreamProvider<List<ReminderEntity>>((ref) {
  return sl<ReminderRepository>().getReminders();
});

class ReminderNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> add(ReminderEntity reminder) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => sl<ReminderRepository>().addReminder(reminder),
    );
  }

  Future<void> toggle(String id, bool isActive) async {
    state = await AsyncValue.guard(
      () => sl<ReminderRepository>().toggleReminder(id, isActive),
    );
  }

  Future<void> delete(String id) async {
    state = await AsyncValue.guard(
      () => sl<ReminderRepository>().deleteReminder(id),
    );
  }
}

final reminderProvider =
    AsyncNotifierProvider<ReminderNotifier, void>(ReminderNotifier.new);
