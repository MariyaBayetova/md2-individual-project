import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../domain/entities/reminder_entity.dart';
import '../providers/reminder_providers.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reminders = ref.watch(remindersStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Reminders')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddReminderSheet(context, ref),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Reminder',
            style: TextStyle(color: Colors.white)),
      ),
      body: reminders.when(
        loading: () => const ShimmerList(count: 4, itemHeight: 90),
        error: (e, _) =>
            ErrorView(message: 'Could not load reminders.\n$e'),
        data: (list) => list.isEmpty
            ? const EmptyView(
                message:
                    'No medicine reminders yet.\nTap + to add one.',
                icon: Icons.medication_outlined,
              )
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
                itemCount: list.length,
                itemBuilder: (context, index) =>
                    _ReminderCard(reminder: list[index]),
              ),
      ),
    );
  }

  void _showAddReminderSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _AddReminderSheet(),
    );
  }
}

class _ReminderCard extends ConsumerWidget {
  final ReminderEntity reminder;
  const _ReminderCard({required this.reminder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: reminder.isActive
              ? AppColors.primary.withValues(alpha: 0.3)
              : AppColors.neutral200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: reminder.isActive
                  ? AppColors.primaryContainer
                  : AppColors.neutral100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.medication_rounded,
              color: reminder.isActive
                  ? AppColors.primary
                  : AppColors.neutral400,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.medicineName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: reminder.isActive
                            ? null
                            : AppColors.neutral400,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${reminder.dosage} · ${reminder.frequency}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.neutral400,
                      ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,
                        size: 12, color: AppColors.primary),
                    const SizedBox(width: 4),
                    Text(
                      reminder.time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Switch(
                value: reminder.isActive,
                activeThumbColor: AppColors.primary,
                onChanged: (v) => ref
                    .read(reminderProvider.notifier)
                    .toggle(reminder.id, v),
              ),
              GestureDetector(
                onTap: () => ref
                    .read(reminderProvider.notifier)
                    .delete(reminder.id),
                child: const Icon(Icons.delete_outline,
                    size: 18, color: AppColors.error),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddReminderSheet extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AddReminderSheet> createState() =>
      _AddReminderSheetState();
}

class _AddReminderSheetState extends ConsumerState<_AddReminderSheet> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _notesController = TextEditingController();
  String _frequency = 'Once daily';
  String _time = '08:00';

  final _frequencies = [
    'Once daily',
    'Twice daily',
    'Three times daily',
    'Every 8 hours',
    'As needed',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add Medicine Reminder',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _field('Medicine Name', _nameController,
              hint: 'e.g. Panadol'),
          const SizedBox(height: 10),
          _field('Dosage', _dosageController, hint: 'e.g. 500mg'),
          const SizedBox(height: 10),

          // Frequency dropdown
          DropdownButtonFormField<String>(
            value: _frequency,
            decoration: _inputDecoration('Frequency'),
            items: _frequencies
                .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                .toList(),
            onChanged: (v) => setState(() => _frequency = v!),
          ),
          const SizedBox(height: 10),

          // Time picker
          GestureDetector(
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: int.parse(_time.split(':')[0]),
                  minute: int.parse(_time.split(':')[1]),
                ),
              );
              if (picked != null) {
                setState(() => _time =
                    '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}');
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.neutral200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time_outlined,
                      color: AppColors.primary, size: 18),
                  const SizedBox(width: 10),
                  Text('Reminder time: $_time',
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _field('Notes (optional)', _notesController,
              hint: 'Take with food', maxLines: 2),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_nameController.text.trim().isEmpty) return;
                await ref.read(reminderProvider.notifier).add(
                      ReminderEntity(
                        id: '',
                        medicineName: _nameController.text.trim(),
                        dosage: _dosageController.text.trim(),
                        frequency: _frequency,
                        time: _time,
                        isActive: true,
                        notes: _notesController.text.trim(),
                        createdAt: DateTime.now(),
                      ),
                    );
                if (context.mounted) Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Save Reminder'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController controller,
      {String hint = '', int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: _inputDecoration(label).copyWith(hintText: hint),
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.neutral200),
        ),
      );
}
