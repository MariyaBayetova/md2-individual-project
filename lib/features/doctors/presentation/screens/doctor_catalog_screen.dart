// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import '../../../../core/constants/app_constants.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/offline_banner.dart';
// import '../../../../core/widgets/state_widgets.dart';
// import '../providers/doctor_providers.dart';
// import '../widgets/doctor_card.dart';

// class DoctorCatalogScreen extends ConsumerWidget {
//   const DoctorCatalogScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;
//     final doctors = ref.watch(filteredDoctorsProvider);
//     final selectedSpec = ref.watch(selectedSpecialtyProvider);
//     final query = ref.watch(doctorSearchQueryProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text(l.findDoctor)),
//       body: Column(
//         children: [
//           const OfflineBanner(),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
//             child: TextField(
//               onChanged: (v) =>
//                   ref.read(doctorSearchQueryProvider.notifier).state = v,
//               decoration: InputDecoration(
//                 hintText: l.searchDoctor,
//                 prefixIcon: const Icon(Icons.search),
//                 suffixIcon: query.isNotEmpty
//                     ? IconButton(
//                         icon: const Icon(Icons.close),
//                         onPressed: () => ref
//                             .read(doctorSearchQueryProvider.notifier)
//                             .state = '',
//                       )
//                     : null,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 48,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 8),
//                   child: FilterChip(
//                     label: const Text('All'),
//                     selected: selectedSpec == null,
//                     onSelected: (_) => ref
//                         .read(selectedSpecialtyProvider.notifier)
//                         .state = null,
//                   ),
//                 ),
//                 ...AppConstants.specialties.map((s) => Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: FilterChip(
//                         label: Text(s),
//                         selected: selectedSpec == s,
//                         onSelected: (_) => ref
//                             .read(selectedSpecialtyProvider.notifier)
//                             .state = selectedSpec == s ? null : s,
//                       ),
//                     )),
//               ],
//             ),
//           ),
//           const SizedBox(height: 4),
//           Expanded(
//             child: doctors.when(
//               loading: () => const ShimmerList(itemHeight: 100),
//               error: (e, _) => ErrorView(
//                 message: e.toString(),
//                 onRetry: () => ref.invalidate(allDoctorsProvider),
//               ),
//               data: (list) => list.isEmpty
//                   ? EmptyView(
//                       message: l.errorOccurred,
//                       icon: Icons.search_off,
//                     )
//                   : RefreshIndicator(
//                       onRefresh: () async =>
//                           ref.invalidate(allDoctorsProvider),
//                       child: ListView.builder(
//                         padding: const EdgeInsets.all(16),
//                         itemCount: list.length,
//                         itemBuilder: (context, i) => DoctorCard(
//                           doctor: list[i],
//                           onTap: () => context.push(
//                             '/doctors/${list[i].id}',
//                             extra: {
//                               'name': list[i].name,
//                               'specialty': list[i].specialty,
//                               'avatarUrl': list[i].avatarUrl,
//                               'rating': list[i].rating,
//                               'reviewCount': list[i].reviewCount,
//                               'experienceYears': list[i].experienceYears,
//                               'consultationFee': list[i].consultationFee,
//                               'about': list[i].about,
//                               'isAvailable': list[i].isAvailable,
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/doctor_providers.dart';
import '../widgets/doctor_card.dart';

class DoctorCatalogScreen extends ConsumerWidget {
  const DoctorCatalogScreen({super.key});


  static const _specialtyKeys = [
    'cardiologist',
    'neurologist',
    'dentist',
    'pediatrician',
    'dermatologist',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final doctors = ref.watch(filteredDoctorsProvider);
    final selectedSpec = ref.watch(selectedSpecialtyProvider);
    final query = ref.watch(doctorSearchQueryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.findDoctor)),
      body: Column(
        children: [
          const OfflineBanner(),

          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              onChanged: (v) =>
                  ref.read(doctorSearchQueryProvider.notifier).state = v,
              decoration: InputDecoration(
                hintText: l.searchDoctor,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => ref
                            .read(doctorSearchQueryProvider.notifier)
                            .state = '',
                      )
                    : null,
              ),
            ),
          ),

          // Specialty Filters
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // "All" chip
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: 
                  FilterChip(
                    label: Text(l.seeAll),
                    selected: selectedSpec == null,
                    onSelected: (_) => ref
                        .read(selectedSpecialtyProvider.notifier)
                        .state = null,
                    selectedColor: Theme.of(context).colorScheme.primaryContainer, 
                    checkmarkColor: AppColors.primary,
                  ),
                
                ),

                // Specialty chips (translated)
                ..._specialtyKeys.map((key) {
                  final label = _getSpecialtyLabel(l, key);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: 
                    FilterChip(
  label: Text(label),
  selected: selectedSpec == key,
  onSelected: (_) {
    ref.read(selectedSpecialtyProvider.notifier).state =
        selectedSpec == key ? null : key;
  },

  selectedColor: Theme.of(context).colorScheme.primaryContainer, 
  checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
  labelStyle: TextStyle(
    color: selectedSpec == label 
        ? Theme.of(context).colorScheme.onPrimaryContainer 
        : Theme.of(context).colorScheme.onSurface,
  ),
),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 4),

          // Doctors List
          Expanded(
            child: doctors.when(
              loading: () => const ShimmerList(itemHeight: 100),
              error: (e, st) {
                debugPrint('❌ Error loading doctors: $e\n$st');
                return ErrorView(
                  message: l.errorOccurred,
                  onRetry: () => ref.invalidate(allDoctorsProvider),
                );
              },
              data: (list) {
                if (list.isEmpty) {
                  return EmptyView(
                    message: query.isNotEmpty
                        ? 'No doctors found for "$query"'
                        : 'No doctors available',
                    icon: Icons.search_off,
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(allDoctorsProvider),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    itemBuilder: (context, i) => DoctorCard(
                      doctor: list[i],
                      onTap: () => context.push(
                        '/doctors/${list[i].id}',
                        extra: {
                          'name': list[i].name,
                          'specialty': list[i].specialty,
                          'avatarUrl': list[i].avatarUrl,
                          'rating': list[i].rating,
                          'reviewCount': list[i].reviewCount,
                          'experienceYears': list[i].experienceYears,
                          'consultationFee': list[i].consultationFee,
                          'about': list[i].about,
                          'isAvailable': list[i].isAvailable,
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Получить перевод специальности
  String _getSpecialtyLabel(AppLocalizations l, String key) {
    return switch (key) {
      'cardiologist' => l.cardiologist,
      'neurologist' => l.neurologist,
      'dentist' => l.dentist,
      'pediatrician' => l.pediatrician,
      'dermatologist' => l.dermatologist,
      _ => key,
    };
  }
}