// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:medical_appointment_app/core/utils/specialty_localizer.dart';
// import 'package:medical_appointment_app/features/doctors/presentation/providers/doctor_providers.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import 'package:table_calendar/table_calendar.dart';
// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/router/app_router.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/app_button.dart';
// import '../../domain/entities/appointment_entity.dart';
// import '../../domain/usecases/get_available_slots_usecase.dart';
// import '../providers/appointment_providers.dart';

// class BookingScreen extends ConsumerWidget {
//   final Map<String, dynamic> extra;
//   const BookingScreen({super.key, required this.extra});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;
    
//     // Данные из extra
//     final doctorId = extra['doctorId'] as String;
//     final doctorName = extra['doctorName'] as String;
//     final specialty = extra['specialty'] as String;
//     final fee = (extra['fee'] as num).toDouble();
//     final avatarUrl = extra['avatarUrl'] as String? ?? '';

//     // Состояния провайдеров
//     final selectedDate = ref.watch(selectedDateProvider);
//     final selectedSlot = ref.watch(selectedTimeSlotProvider);
//     final bookingState = ref.watch(bookingProvider);
//     final slots = ref.watch(availableSlotsProvider(selectedDate));
//     final uid = ref.watch(currentUserIdProvider);

//     //  Слушатель событий (Fix: Navigator Error & Clean Architecture) 
//     ref.listen<AsyncValue>(bookingProvider, (previous, next) {
//       if (next is AsyncData && previous is AsyncLoading) {
//         // Используем microtask, чтобы дождаться завершения отрисовки текущего кадра
//         Future.microtask(() {
//           if (context.mounted) {
//             _showSuccessDialog(context, l, doctorName, selectedSlot ?? '');
//           }
//         });
//       }

//       if (next is AsyncError) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(next.error.toString()),
//           backgroundColor: AppColors.error,
//         ));
//       }
//     });

//     return Scaffold(
//       appBar: AppBar(title: Text(l.bookAppointment)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _DoctorInfoCard(
//               doctorId: doctorId,
//               doctorName: doctorName,
//               specialty: specialty,
//               fee: fee,
//               avatarUrl: avatarUrl,
//             ),
//             const SizedBox(height: 24),

//             Text(
//               l.selectDate,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleSmall
//                   ?.copyWith(fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 12),
//             Card(
//               child: TableCalendar(
//                 firstDay: DateTime.now(),
//                 lastDay: DateTime.now().add(const Duration(days: 60)),
//                 focusedDay: selectedDate,
//                 selectedDayPredicate: (d) => isSameDay(d, selectedDate),
//                 onDaySelected: (selected, _) {
//                   ref.read(selectedDateProvider.notifier).state = selected;
//                   ref.read(selectedTimeSlotProvider.notifier).state = null;
//                 },
//                 calendarStyle: CalendarStyle(
//                   selectedDecoration: const BoxDecoration(
//                     color: AppColors.primary,
//                     shape: BoxShape.circle,
//                   ),
//                   todayDecoration: BoxDecoration(
//                     color: AppColors.primaryLight.withOpacity(0.4),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 headerStyle: const HeaderStyle(
//                   formatButtonVisible: false,
//                   titleCentered: true,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             Text(
//               l.selectTime,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleSmall
//                   ?.copyWith(fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: slots.map((slotStatus) {
//                 final isSelected = slotStatus.slot == selectedSlot;
//                 return _TimeSlotChip(
//                   slotStatus: slotStatus,
//                   isSelected: isSelected,
//                   onTap: slotStatus.isDisabled
//                       ? null
//                       : () => ref
//                           .read(selectedTimeSlotProvider.notifier)
//                           .state = isSelected ? null : slotStatus.slot,
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 32),

          
//             AppButton(
//               label: l.confirmAppointment,
//               isLoading: bookingState.isLoading,
//               onPressed: selectedSlot == null || bookingState.isLoading
//                   ? null
//                   : () {
//                       final timeParts = selectedSlot.split(':');
//                       final dt = DateTime(
//                         selectedDate.year,
//                         selectedDate.month,
//                         selectedDate.day,
//                         int.parse(timeParts[0]),
//                         int.parse(timeParts[1]),
//                       );

//                       final appt = AppointmentEntity(
//                         id: '',
//                         userId: uid,
//                         doctorId: doctorId,
//                         doctorName: doctorName,
//                         doctorSpecialty: specialty,
//                         doctorAvatarUrl: avatarUrl,
//                         dateTime: dt,
//                         status: AppConstants.statusConfirmed,
//                         fee: fee,
//                       );

//                       // Только запускаем процесс, результат обработает ref.listen
//                       ref.read(bookingProvider.notifier).book(appt);
//                     },
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSuccessDialog(
//     BuildContext context,
//     AppLocalizations l,
//     String doctorName,
//     String slot,
//   ) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.success, size: 64),
//             const SizedBox(height: 16),
//             Text(
//               l.appointmentBooked,
//               style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Dr. $doctorName · $slot',
//               style: const TextStyle(color: AppColors.neutral600),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => context.go(Routes.appointments),
//             child: Text(l.viewAppointments),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class _DoctorInfoCard extends ConsumerWidget {
//   final String doctorId;
//   final String doctorName;
//   final String specialty;
//   final double fee;
//   final String avatarUrl;

//   const _DoctorInfoCard({
//     required this.doctorId,
//     required this.doctorName,
//     required this.specialty,
//     required this.fee,
//     required this.avatarUrl,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;

//     return GestureDetector(
//       onTap: () async {
//         final allDoctors = await ref.read(allDoctorsProvider.future);
//         final doctor = allDoctors.where((d) => d.id == doctorId).firstOrNull;

//         if (!context.mounted) return;

        
//         context.pushReplacement(
//           '/doctors/$doctorId',
//           extra: {
//             'name': doctor?.name ?? doctorName,
//             'specialty': doctor?.specialty ?? specialty,
//             'avatarUrl': doctor?.avatarUrl ?? avatarUrl,
//             'rating': doctor?.rating ?? 4.5,
//             'reviewCount': doctor?.reviewCount ?? 0,
//             'experienceYears': doctor?.experienceYears ?? 0,
//             'consultationFee': doctor?.consultationFee ?? fee,
//             'about': doctor?.about ?? '',
//             'isAvailable': doctor?.isAvailable ?? true,
//           },
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppColors.primary.withOpacity(0.3)),
//         ),
//         child: Row(children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.primaryContainer,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.local_hospital_rounded,
//               color: AppColors.primary,
//               size: 22,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(children: [
//                   Text(
//                     'Dr. $doctorName',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleSmall
//                         ?.copyWith(fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(width: 4),
//                   const Icon(
//                     Icons.chevron_right,
//                     size: 16,
//                     color: AppColors.neutral400,
//                   ),
//                 ]),
//                 const SizedBox(height: 2),
//                 Text(
//                   localizeSpecialty(context, specialty),
//                   style: const TextStyle(fontSize: 12, color: AppColors.primary),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               color: AppColors.primaryContainer,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               '${l.currency} ${fee.toStringAsFixed(0)}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.primary,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class _TimeSlotChip extends StatelessWidget {
//   final SlotStatus slotStatus;
//   final bool isSelected;
//   final VoidCallback? onTap;

//   const _TimeSlotChip({
//     required this.slotStatus,
//     required this.isSelected,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: slotStatus.isDisabled
//               ? AppColors.neutral200
//               : isSelected
//                   ? AppColors.primary
//                   : AppColors.neutral100,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Text(
//           slotStatus.isDisabled ? '${slotStatus.slot} ✕' : slotStatus.slot,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: slotStatus.isDisabled
//                 ? AppColors.neutral400
//                 : isSelected
//                     ? Colors.white
//                     : AppColors.neutral600,
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:medical_appointment_app/core/utils/specialty_localizer.dart';
// import 'package:medical_appointment_app/features/doctors/presentation/providers/doctor_providers.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import 'package:table_calendar/table_calendar.dart';
// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/router/app_router.dart';
// import '../../../../core/services/notification_service.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/app_button.dart';
// import '../../domain/entities/appointment_entity.dart';
// import '../providers/appointment_providers.dart';

// class BookingScreen extends ConsumerWidget {
//   final Map<String, dynamic> extra;
//   const BookingScreen({super.key, required this.extra});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;

//     final doctorId = extra['doctorId'] as String;
//     final doctorName = extra['doctorName'] as String;
//     final specialty = extra['specialty'] as String;
//     final fee = (extra['fee'] as num).toDouble();
//     final avatarUrl = extra['avatarUrl'] as String? ?? '';

//     final selectedDate = ref.watch(selectedDateProvider);
//     final selectedSlot = ref.watch(selectedTimeSlotProvider);
//     final bookingState = ref.watch(bookingProvider);
//     final bookedSlots = ref.watch(bookedSlotsProvider(doctorId));
//     final occupied = bookedSlots.asData?.value ?? [];

//     ref.listen<AsyncValue>(bookingProvider, (previous, next) {
//       if (next is AsyncData && previous is AsyncLoading) {
//         Future.microtask(() {
//           if (context.mounted) {
//             final dateStr =
//                 '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
//             NotificationService.showBookingConfirmation(
//               context: context,
//               doctorName: doctorName,
//               time: selectedSlot ?? '',
//               date: dateStr,
//             );
//             _showSuccessDialog(context, l, doctorName, selectedSlot ?? '');
//           }
//         });
//       }

//       if (next is AsyncError) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(next.error.toString()),
//           backgroundColor: AppColors.error,
//         ));
//       }
//     });

//     return Scaffold(
//       appBar: AppBar(title: Text(l.bookAppointment)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _DoctorInfoCard(
//               doctorId: doctorId,
//               doctorName: doctorName,
//               specialty: specialty,
//               fee: fee,
//               avatarUrl: avatarUrl,
//             ),
//             const SizedBox(height: 24),

//             Text(
//               l.selectDate,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleSmall
//                   ?.copyWith(fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 12),
//             Card(
//               child: TableCalendar(
//                 firstDay: DateTime.now(),
//                 lastDay: DateTime.now().add(const Duration(days: 60)),
//                 focusedDay: selectedDate,
//                 selectedDayPredicate: (d) => isSameDay(d, selectedDate),
//                 onDaySelected: (selected, _) {
//                   ref.read(selectedDateProvider.notifier).state = selected;
//                   ref.read(selectedTimeSlotProvider.notifier).state = null;
//                 },
//                 calendarStyle: CalendarStyle(
//                   selectedDecoration: const BoxDecoration(
//                     color: AppColors.primary,
//                     shape: BoxShape.circle,
//                   ),
//                   todayDecoration: BoxDecoration(
//                     color: AppColors.primaryLight.withOpacity(0.4),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 headerStyle: const HeaderStyle(
//                   formatButtonVisible: false,
//                   titleCentered: true,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             Text(
//               l.selectTime,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleSmall
//                   ?.copyWith(fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: AppConstants.timeSlots.map((slot) {
//                 final isSelected = slot == selectedSlot;
//                 final slotKey =
//                     '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}-$slot';
//                 final isTaken = occupied.contains(slotKey);

//                 return _TimeSlotChip(
//                   slot: slot,
//                   isSelected: isSelected,
//                   isTaken: isTaken,
//                   onTap: isTaken
//                       ? null
//                       : () => ref
//                           .read(selectedTimeSlotProvider.notifier)
//                           .state = isSelected ? null : slot,
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 32),

//             AppButton(
//               label: l.confirmAppointment,
//               isLoading: bookingState.isLoading,
//               onPressed: selectedSlot == null || bookingState.isLoading
//                   ? null
//                   : () {
//                       final timeParts = selectedSlot.split(':');
//                       final dt = DateTime(
//                         selectedDate.year,
//                         selectedDate.month,
//                         selectedDate.day,
//                         int.parse(timeParts[0]),
//                         int.parse(timeParts[1]),
//                       );
//                       final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
//                       final appt = AppointmentEntity(
//                         id: '',
//                         userId: uid,
//                         doctorId: doctorId,
//                         doctorName: doctorName,
//                         doctorSpecialty: specialty,
//                         doctorAvatarUrl: avatarUrl,
//                         dateTime: dt,
//                         status: AppConstants.statusConfirmed,
//                         fee: fee,
//                       );

//                       ref.read(bookingProvider.notifier).book(appt);
//                     },
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSuccessDialog(
//     BuildContext context,
//     AppLocalizations l,
//     String doctorName,
//     String slot,
//   ) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.success, size: 64),
//             const SizedBox(height: 16),
//             Text(
//               l.appointmentBooked,
//               style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Dr. $doctorName · $slot',
//               style: const TextStyle(color: AppColors.neutral600),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => context.go(Routes.appointments),
//             child: Text(l.viewAppointments),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DoctorInfoCard extends ConsumerWidget {
//   final String doctorId;
//   final String doctorName;
//   final String specialty;
//   final double fee;
//   final String avatarUrl;

//   const _DoctorInfoCard({
//     required this.doctorId,
//     required this.doctorName,
//     required this.specialty,
//     required this.fee,
//     required this.avatarUrl,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;

//     return GestureDetector(
//       onTap: () async {
//         final allDoctors = await ref.read(allDoctorsProvider.future);
//         final doctor = allDoctors.where((d) => d.id == doctorId).firstOrNull;

//         if (!context.mounted) return;

//         context.pushReplacement(
//           '/doctors/$doctorId',
//           extra: {
//             'name': doctor?.name ?? doctorName,
//             'specialty': doctor?.specialty ?? specialty,
//             'avatarUrl': doctor?.avatarUrl ?? avatarUrl,
//             'rating': doctor?.rating ?? 4.5,
//             'reviewCount': doctor?.reviewCount ?? 0,
//             'experienceYears': doctor?.experienceYears ?? 0,
//             'consultationFee': doctor?.consultationFee ?? fee,
//             'about': doctor?.about ?? '',
//             'isAvailable': doctor?.isAvailable ?? true,
//           },
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppColors.primary.withOpacity(0.3)),
//         ),
//         child: Row(children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.primaryContainer,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.local_hospital_rounded,
//               color: AppColors.primary,
//               size: 22,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(children: [
//                   Text(
//                     'Dr. $doctorName',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleSmall
//                         ?.copyWith(fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(width: 4),
//                   const Icon(
//                     Icons.chevron_right,
//                     size: 16,
//                     color: AppColors.neutral400,
//                   ),
//                 ]),
//                 const SizedBox(height: 2),
//                 Text(
//                   localizeSpecialty(context, specialty),
//                   style: const TextStyle(fontSize: 12, color: AppColors.primary),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//             decoration: BoxDecoration(
//               color: AppColors.primaryContainer,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               '${fee.toStringAsFixed(0)} ${l.currency}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.w700,
//                 color: AppColors.primary,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class _TimeSlotChip extends StatelessWidget {
//   final String slot;
//   final bool isSelected;
//   final bool isTaken;
//   final VoidCallback? onTap;

//   const _TimeSlotChip({
//     required this.slot,
//     required this.isSelected,
//     required this.isTaken,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           color: isTaken
//               ? AppColors.neutral200
//               : isSelected
//                   ? AppColors.primary
//                   : AppColors.neutral100,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Text(
//           isTaken ? '$slot ✕' : slot,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: isTaken
//                 ? AppColors.neutral400
//                 : isSelected
//                     ? Colors.white
//                     : AppColors.neutral600,
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:medical_appointment_app/core/utils/specialty_localizer.dart';
// import 'package:medical_appointment_app/features/doctors/presentation/providers/doctor_providers.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import 'package:table_calendar/table_calendar.dart';
// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/router/app_router.dart';
// import '../../../../core/services/notification_service.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/app_button.dart';
// import '../../domain/entities/appointment_entity.dart';
// import '../providers/appointment_providers.dart';

// class BookingScreen extends ConsumerWidget {
//   final Map<String, dynamic> extra;
//   const BookingScreen({super.key, required this.extra});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;

//     final doctorId = extra['doctorId'] as String;
//     final doctorName = extra['doctorName'] as String;
//     final specialty = extra['specialty'] as String;
//     final fee = (extra['fee'] as num).toDouble();
//     final avatarUrl = extra['avatarUrl'] as String? ?? '';

//     final selectedDate = ref.watch(selectedDateProvider);
//     final selectedSlot = ref.watch(selectedTimeSlotProvider);
//     final bookingState = ref.watch(bookingProvider);
//     final bookedSlots = ref.watch(bookedSlotsProvider(doctorId));
//     final occupied = bookedSlots.asData?.value ?? [];

//     ref.listen<AsyncValue>(bookingProvider, (previous, next) {
//       if (next is AsyncData && previous is AsyncLoading) {
//         Future.microtask(() {
//           if (context.mounted) {
//             final dateStr =
//                 '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
//             NotificationService.showBookingConfirmation(
//               context: context,
//               doctorName: doctorName,
//               time: selectedSlot ?? '',
//               date: dateStr,
//             );
//             _showSuccessDialog(context, l, doctorName, selectedSlot ?? '');
//           }
//         });
//       }

//       if (next is AsyncError) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(next.error.toString()),
//           backgroundColor: AppColors.error,
//         ));
//       }
//     });

//     return Scaffold(
//       appBar: AppBar(title: Text(l.bookAppointment)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _DoctorInfoCard(
//               doctorId: doctorId,
//               doctorName: doctorName,
//               specialty: specialty,
//               fee: fee,
//               avatarUrl: avatarUrl,
//             ),
//             const SizedBox(height: 24),

//             Text(
//               l.selectDate,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleSmall
//                   ?.copyWith(fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 12),
//             Card(
//               child: TableCalendar(
//                 firstDay: DateTime.now(),
//                 lastDay: DateTime.now().add(const Duration(days: 60)),
//                 focusedDay: selectedDate,
//                 selectedDayPredicate: (d) => isSameDay(d, selectedDate),
//                 onDaySelected: (selected, _) {
//                   ref.read(selectedDateProvider.notifier).state = selected;
//                   ref.read(selectedTimeSlotProvider.notifier).state = null;
//                 },
//                 calendarStyle: CalendarStyle(
//                   selectedDecoration: const BoxDecoration(
//                     color: AppColors.primary,
//                     shape: BoxShape.circle,
//                   ),
//                   todayDecoration: BoxDecoration(
//                     color: AppColors.primaryLight.withOpacity(0.4),
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 headerStyle: const HeaderStyle(
//                   formatButtonVisible: false,
//                   titleCentered: true,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             Text(
//               l.selectTime,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleSmall
//                   ?.copyWith(fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: AppConstants.timeSlots.map((slot) {
//                 final isSelected = slot == selectedSlot;
//                 final slotKey =
//                     '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}-$slot';
                
//                 // Проверка: занято ли место в базе
//                 final isTaken = occupied.contains(slotKey);

//                 // ЛОГИКА БЛОКИРОВКИ ПРОШЕДШЕГО ВРЕМЕНИ
//                 bool isPast = false;
//                 final now = DateTime.now();
//                 if (isSameDay(selectedDate, now)) {
//                   final parts = slot.split(':');
//                   final hour = int.parse(parts[0]);
//                   final minute = int.parse(parts[1]);
                  
//                   // Создаем объект времени для конкретного слота сегодня
//                   final slotTime = DateTime(now.year, now.month, now.day, hour, minute);
                  
//                   // Если время слота меньше текущего — он в прошлом
//                   if (slotTime.isBefore(now)) {
//                     isPast = true;
//                   }
//                 }

//                 // Слот недоступен, если он занят ИЛИ уже прошел
//                 final bool isUnavailable = isTaken || isPast;

//                 return _TimeSlotChip(
//                   slot: slot,
//                   isSelected: isSelected,
//                   isTaken: isUnavailable,
//                   onTap: isUnavailable
//                       ? null
//                       : () => ref
//                           .read(selectedTimeSlotProvider.notifier)
//                           .state = isSelected ? null : slot,
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 32),

//             AppButton(
//               label: l.confirmAppointment,
//               isLoading: bookingState.isLoading,
//               onPressed: selectedSlot == null || bookingState.isLoading
//                   ? null
//                   : () {
//                       final timeParts = selectedSlot.split(':');
//                       final dt = DateTime(
//                         selectedDate.year,
//                         selectedDate.month,
//                         selectedDate.day,
//                         int.parse(timeParts[0]),
//                         int.parse(timeParts[1]),
//                       );
//                       final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
//                       final appt = AppointmentEntity(
//                         id: '',
//                         userId: uid,
//                         doctorId: doctorId,
//                         doctorName: doctorName,
//                         doctorSpecialty: specialty,
//                         doctorAvatarUrl: avatarUrl,
//                         dateTime: dt,
//                         status: AppConstants.statusConfirmed,
//                         fee: fee,
//                       );

//                       ref.read(bookingProvider.notifier).book(appt);
//                     },
//             ),
//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showSuccessDialog(
//     BuildContext context,
//     AppLocalizations l,
//     String doctorName,
//     String slot,
//   ) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.check_circle_rounded,
//                 color: AppColors.success, size: 64),
//             const SizedBox(height: 16),
//             Text(
//               l.appointmentBooked,
//               style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Dr. $doctorName · $slot',
//               style: const TextStyle(color: AppColors.neutral600),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => context.go(Routes.appointments),
//             child: Text(l.viewAppointments),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/core/utils/specialty_localizer.dart';
import 'package:medical_appointment_app/features/doctors/presentation/providers/doctor_providers.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/appointment_entity.dart';
import '../providers/appointment_providers.dart';

class BookingScreen extends ConsumerStatefulWidget { 
  final Map<String, dynamic> extra;
  const BookingScreen({super.key, required this.extra});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.invalidate(selectedTimeSlotProvider);
      ref.invalidate(bookingProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    // 1. ИСПРАВЛЕНИЕ: Достаем ВСЕ данные из extra, которые могут понадобиться для возврата
    final doctorId = widget.extra['doctorId'] as String;
    final doctorName = widget.extra['doctorName'] as String;
    final specialty = widget.extra['specialty'] as String;
    final fee = (widget.extra['fee'] as num).toDouble();
    final avatarUrl = widget.extra['avatarUrl'] as String? ?? '';
final about = widget.extra['about'] as String? ?? '';
  final rating = (widget.extra['rating'] as num?)?.toDouble() ?? 0.0;
  final exp = widget.extra['experienceYears'] as int? ?? 0;
  final rev = widget.extra['reviewCount'] as int? ?? 0;
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedSlot = ref.watch(selectedTimeSlotProvider);
    final bookingState = ref.watch(bookingProvider);
    final bookedSlots = ref.watch(bookedSlotsProvider(doctorId));
    final occupied = bookedSlots.asData?.value ?? [];

    ref.listen<AsyncValue>(bookingProvider, (previous, next) {
      if (next is AsyncData && previous is AsyncLoading && next.value != null) {
        final dateStr = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        NotificationService.showBookingConfirmation(
          context: context,
          doctorName: doctorName,
          time: selectedSlot ?? '',
          date: dateStr,
        );
        _showSuccessDialog(context, l, doctorName, selectedSlot ?? '');
      }
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(next.error.toString()),
          backgroundColor: AppColors.error,
        ));
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(l.bookAppointment)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            _DoctorInfoCard(
              doctorId: doctorId,
              doctorName: doctorName,
              specialty: specialty,
              fee: fee,
              avatarUrl: avatarUrl,
              about: about,       
    rating: rating,     
    experience: exp,    
    reviews: rev,
            ),
            const SizedBox(height: 24),

            Text(
              l.selectDate,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Card(
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 60)),
                focusedDay: selectedDate,
                selectedDayPredicate: (d) => isSameDay(d, selectedDate),
                onDaySelected: (selected, _) {
                  ref.read(selectedDateProvider.notifier).state = selected;
                  ref.read(selectedTimeSlotProvider.notifier).state = null;
                },
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                ),
                headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              l.selectTime,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppConstants.timeSlots.map((slot) {
                final isSelected = slot == selectedSlot;
                final slotKey = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}-$slot';
                final isTaken = occupied.contains(slotKey);

                bool isPast = false;
                final now = DateTime.now();
                if (isSameDay(selectedDate, now)) {
                  final parts = slot.split(':');
                  final hour = int.parse(parts[0]);
                  final minute = int.parse(parts[1]);
                  final slotTime = DateTime(now.year, now.month, now.day, hour, minute);
                  if (slotTime.isBefore(now)) isPast = true;
                }
                final bool isUnavailable = isTaken || isPast;

                return _TimeSlotChip(
                  slot: slot,
                  isSelected: isSelected,
                  isTaken: isUnavailable,
                  onTap: isUnavailable ? null : () => ref.read(selectedTimeSlotProvider.notifier).state = isSelected ? null : slot,
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            AppButton(
              label: l.confirmAppointment,
              isLoading: bookingState.isLoading,
              onPressed: selectedSlot == null || bookingState.isLoading
                  ? null
                  : () {
                      final timeParts = selectedSlot.split(':');
                      final dt = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, int.parse(timeParts[0]), int.parse(timeParts[1]));
                      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
                      final appt = AppointmentEntity(
                        id: '',
                        userId: uid,
                        doctorId: doctorId,
                        doctorName: doctorName,
                        doctorSpecialty: specialty,
                        doctorAvatarUrl: avatarUrl,
                        dateTime: dt,
                        status: AppConstants.statusConfirmed,
                        fee: fee,
                      );
                      ref.read(bookingProvider.notifier).book(appt);
                    },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, AppLocalizations l, String doctorName, String slot) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 64),
            const SizedBox(height: 16),
            Text(l.appointmentBooked, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 8),
            Text('Dr. $doctorName · $slot', style: const TextStyle(color: AppColors.neutral600)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.go(Routes.appointments),
            child: Text(l.viewAppointments),
          ),
        ],
      ),
    );
  }
}

class _DoctorInfoCard extends ConsumerWidget {
  final String doctorId;
  final String doctorName;
  final String specialty;
  final double fee;
  final String avatarUrl;
  final String about;
  final double rating;
  final int experience;
  final int reviews;

  const _DoctorInfoCard({
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.fee,
    required this.avatarUrl,
    required this.about,
    required this.rating,
    required this.experience,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () async {
        final allDoctors = await ref.read(allDoctorsProvider.future);
        final doctor = allDoctors.where((d) => d.id == doctorId).firstOrNull;

        if (!context.mounted) return;

        context.pushReplacement(
          '/doctors/$doctorId',
          extra: {
            'name': doctor?.name ?? doctorName,
            'specialty': doctor?.specialty ?? specialty,
            'avatarUrl': doctor?.avatarUrl ?? avatarUrl,
            'rating': doctor?.rating ?? rating,
            'reviewCount': doctor?.reviewCount ?? reviews,
            'experienceYears': doctor?.experienceYears ?? experience,
            'consultationFee': doctor?.consultationFee ?? fee,
            'about': doctor?.about ?? about, 
            'isAvailable': doctor?.isAvailable ?? true,
          },
        );
      },

      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.local_hospital_rounded, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text('Dr. $doctorName', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right, size: 16, color: AppColors.neutral400),
                ]),
                const SizedBox(height: 2),
                Text(localizeSpecialty(context, specialty), style: const TextStyle(fontSize: 12, color: AppColors.primary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(8)),
            child: Text(
              '${fee.toStringAsFixed(0)} ${l.currency}', 
              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary, fontSize: 15),
            ),
          ),
        ]),
      ),
    );
  }
}

class _TimeSlotChip extends StatelessWidget {
  final String slot;
  final bool isSelected;
  final bool isTaken;
  final VoidCallback? onTap;

  const _TimeSlotChip({required this.slot, required this.isSelected, required this.isTaken, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isTaken ? AppColors.neutral200 : isSelected ? AppColors.primary : AppColors.neutral100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          isTaken ? '$slot ✕' : slot,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isTaken ? AppColors.neutral400 : isSelected ? Colors.white : AppColors.neutral600,
          ),
        ),
      ),
    );
  }
}