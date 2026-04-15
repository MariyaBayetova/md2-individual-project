// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl/intl.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import '../../../../core/router/app_router.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/offline_banner.dart';
// import '../../../../core/widgets/state_widgets.dart';
// import '../../../appointments/presentation/providers/appointment_providers.dart';
// import '../../../doctors/presentation/providers/doctor_providers.dart';

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;
//     final user = FirebaseAuth.instance.currentUser;
//     final firstName = (user?.displayName ?? l.profile).split(' ').first;
//     final size = MediaQuery.sizeOf(context);
//     final isWide = size.width > 600;

//     return Scaffold(
//       body: SafeArea(
//         child: Column(children: [
//           const OfflineBanner(),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.symmetric(
//                 horizontal: isWide ? size.width * 0.1 : 20,
//                 vertical: 16,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Header
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '${_getGreeting(l)} 👋',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium
//                                   ?.copyWith(color: AppColors.neutral600),
//                             ),
//                             const SizedBox(height: 2),
//                             Text(
//                               firstName,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall
//                                   ?.copyWith(fontWeight: FontWeight.w700),
//                             ),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => context.go(Routes.patientCard),
//                         child: CircleAvatar(
//                           radius: 22,
//                           backgroundColor: AppColors.primaryContainer,
//                           child: Text(
//                             firstName.isNotEmpty
//                                 ? firstName[0].toUpperCase()
//                                 : 'P',
//                             style: const TextStyle(
//                                 color: AppColors.primary,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),

//                   // Next Appointment Banner
//                   _NextAppointmentBanner(),
//                   const SizedBox(height: 24),

//                   // Quick Actions
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _QuickAction(
//                           icon: Icons.add_circle_outline,
//                           label: l.bookAppointment,
//                           color: AppColors.primary,
//                           onTap: () => context.go(Routes.doctors),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: _QuickAction(
//                           icon: Icons.search_rounded,
//                           label: l.findDoctor,
//                           color: AppColors.info,
//                           onTap: () => context.go(Routes.doctors),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: _QuickAction(
//                           icon: Icons.folder_shared_outlined,
//                           label: l.myRecords,
//                           color: AppColors.warning,
//                           onTap: () => context.go(Routes.patientCard),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 28),

//                   // Specialties Section
//                   _SectionHeader(
//                     title: l.specialties,
//                     seeAllLabel: l.seeAll,
//                     onSeeAll: () => context.go(Routes.doctors),
//                   ),
//                   const SizedBox(height: 12),
//                   _SpecialtiesList(),
//                   const SizedBox(height: 28),

//                   // Top Doctors Section
//                   _SectionHeader(
//                     title: l.topDoctors,
//                     seeAllLabel: l.seeAll,
//                     onSeeAll: () => context.go(Routes.doctors),
//                   ),
//                   const SizedBox(height: 12),
//                   _TopDoctorsList(),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }

//   String _getGreeting(AppLocalizations l) {
//     final hour = DateTime.now().hour;
//     if (hour < 12) return l.good_morning;
//     if (hour < 17) return l.good_afternoon;
//     return l.good_evening;
//   }
// }


// // Next Appointment Banner


// class _NextAppointmentBanner extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;
//     final next = ref.watch(nextAppointmentProvider);

//     return next.when(
//       loading: () => const ShimmerCard(height: 100),
//       error: (_, __) => const SizedBox.shrink(),
//       data: (appt) {
//         if (appt == null) {
//           return Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(18),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [AppColors.primary, AppColors.primaryDark],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   l.noUpcomingAppointments,
//                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                       color: Colors.white, fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   l.bookYourFirst,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodySmall
//                       ?.copyWith(color: Colors.white70),
//                 ),
//               ],
//             ),
//           );
//         }

//         return Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [AppColors.primary, AppColors.primaryDark],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(18),
//           ),
//           child: Row(children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     l.nextAppointment,
//                     style: Theme.of(context)
//                         .textTheme
//                         .labelSmall
//                         ?.copyWith(color: Colors.white70),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Dr. ${appt.doctorName}',
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         color: Colors.white, fontWeight: FontWeight.w700),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     DateFormat('EEE, dd MMM · HH:mm').format(appt.dateTime),
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall
//                         ?.copyWith(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: CachedNetworkImage(
//                 imageUrl: appt.doctorAvatarUrl,
//                 width: 56,
//                 height: 56,
//                 fit: BoxFit.cover,
//                 errorWidget: (_, __, ___) => Container(
//                   width: 56,
//                   height: 56,
//                   color: Colors.white24,
//                   child: const Icon(Icons.person, color: Colors.white),
//                 ),
//               ),
//             ),
//           ]),
//         );
//       },
//     );
//   }
// }


// // Quick Actions


// class _QuickAction extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;
//   final VoidCallback onTap;

//   const _QuickAction({
//     required this.icon,
//     required this.label,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Column(children: [
//           Icon(icon, color: color, size: 26),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             style: TextStyle(
//                 fontSize: 11, fontWeight: FontWeight.w600, color: color),
//           ),
//         ]),
//       ),
//     );
//   }
// }


// // Specialties List


// class _SpecialtiesList extends ConsumerWidget {
//   static const _specialties = [
//     ('cardiologist', Icons.favorite_outline, Color(0xFFEF4444)),
//     ('neurologist', Icons.psychology_outlined, Color(0xFF8B5CF6)),
//     ('dentist', Icons.medical_services_outlined, Color(0xFF06B6D4)),
//     ('pediatrician', Icons.child_care_outlined, Color(0xFFF59E0B)),
//     ('dermatologist', Icons.spa_outlined, Color(0xFF10B981)),
//   ];

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;

//     return SizedBox(
//       height: 90,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _specialties.length,
//         itemBuilder: (_, i) {
//           final (key, icon, color) = _specialties[i];
//           final label = _getSpecialtyLabel(l, key);

//           return _SpecialtyChip(
//             label: label,
//             icon: icon,
//             color: color,
//             onTap: () {
//               ref.read(selectedSpecialtyProvider.notifier).state = label;
//               context.go(Routes.doctors);
//             },
//           );
//         },
//       ),
//     );
//   }

//   String _getSpecialtyLabel(AppLocalizations l, String key) {
//     return switch (key) {
//       'cardiologist' => l.cardiologist,
//       'neurologist' => l.neurologist,
//       'dentist' => l.dentist,
//       'pediatrician' => l.pediatrician,
//       'dermatologist' => l.dermatologist,
//       _ => key,
//     };
//   }
// }

// class _SpecialtyChip extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color color;
//   final VoidCallback onTap;

//   const _SpecialtyChip({
//     required this.label,
//     required this.icon,
//     required this.color,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(right: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: color.withOpacity(0.2)),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: color, size: 22),
//             const SizedBox(height: 5),
//             Text(
//               label,
//               style: TextStyle(
//                   fontSize: 11, fontWeight: FontWeight.w600, color: color),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// // Section Header


// class _SectionHeader extends StatelessWidget {
//   final String title;
//   final String seeAllLabel;
//   final VoidCallback onSeeAll;

//   const _SectionHeader({
//     required this.title,
//     required this.seeAllLabel,
//     required this.onSeeAll,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: Theme.of(context)
//               .textTheme
//               .titleSmall
//               ?.copyWith(fontWeight: FontWeight.w700),
//         ),
//         TextButton(
//           onPressed: onSeeAll,
//           style: TextButton.styleFrom(
//               foregroundColor: AppColors.primary, padding: EdgeInsets.zero),
//           child: Text(seeAllLabel),
//         ),
//       ],
//     );
//   }
// }


// // Top Doctors List


// class _TopDoctorsList extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final docs = ref.watch(allDoctorsProvider);

//     return docs.when(
//       loading: () => SizedBox(
//         height: 160,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: List.generate(4, (_) => const ShimmerCard(height: 160)),
//         ),
//       ),
//       error: (_, __) => const SizedBox.shrink(),
//       data: (list) => SizedBox(
//         height: 160,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: list.take(6).length,
//           itemBuilder: (_, i) {
//             final d = list[i];
//             return GestureDetector(
//               onTap: () => context.push(
//                 '/doctors/${d.id}',
//                 extra: {
//                   'name': d.name,
//                   'specialty': d.specialty,
//                   'avatarUrl': d.avatarUrl,
//                   'rating': d.rating,
//                   'reviewCount': d.reviewCount,
//                   'experienceYears': d.experienceYears,
//                   'consultationFee': d.consultationFee,
//                   'about': d.about,
//                   'isAvailable': d.isAvailable,
//                 },
//               ),
//               child: Container(
//                 width: 120,
//                 margin: const EdgeInsets.only(right: 12),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(14),
//                   border: Border.all(color: AppColors.neutral200),
//                 ),
//                 child: Column(children: [
//                   ClipRRect(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(14)),
//                     child: CachedNetworkImage(
//                       imageUrl: d.avatarUrl,
//                       height: 80,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorWidget: (_, __, ___) => Container(
//                         height: 80,
//                         color: AppColors.primaryContainer,
//                         child: const Icon(Icons.person,
//                             color: AppColors.primary),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Column(children: [
//                       Text(
//                         d.name,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             fontSize: 11, fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         d.specialty,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             fontSize: 10, color: AppColors.primary),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.star_rounded,
//                               color: Color(0xFFF59E0B), size: 12),
//                           const SizedBox(width: 2),
//                           Text(
//                             d.rating.toStringAsFixed(1),
//                             style: const TextStyle(
//                                 fontSize: 10, fontWeight: FontWeight.w600),
//                           ),
//                         ],
//                       ),
//                     ]),
//                   ),
//                 ]),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medical_appointment_app/core/utils/specialty_mapper.dart';
import 'package:medical_appointment_app/features/chat/presentation/screens/call_screen.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../../../appointments/presentation/providers/appointment_providers.dart';
import '../../../doctors/presentation/providers/doctor_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final firstName = (user?.displayName ?? l.profile).split(' ').first;
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: isWide ? size.width * 0.1 : 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_getGreeting(l)} 👋',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.neutral600),
            ),
            Text(
              firstName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => context.go(Routes.patientCard),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryContainer,
                child: Text(
                  firstName.isNotEmpty ? firstName[0].toUpperCase() : 'P',
                  style: const TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          const OfflineBanner(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? size.width * 0.1 : 20,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Next Appointment Banner
                  _NextAppointmentBanner(),
                  const SizedBox(height: 16),

                  // SOS Button
                  _SosButton(),
                  const SizedBox(height: 24),

                  // Quick Actions (4 columns)
                  Row(
                    children: [
                      Expanded(
                        child: _QuickAction(
                          icon: Icons.add_circle_outline,
                          label: l.bookAppointment,
                          color: AppColors.primary,
                          onTap: () => context.go(Routes.doctors),
                        ),
                      ),
                      const SizedBox(width: 10),
                    
Expanded(
  child: _QuickAction(
    icon: Icons.chat_bubble_outline,
    label: l.messages,  
    color: AppColors.info,
    onTap: () => context.go(Routes.messages)
  ),
),
const SizedBox(width: 10),
Expanded(
  child: _QuickAction(
    icon: Icons.emergency_outlined,
    label: l.emergency,  
    color: AppColors.error,
    // onTap: () => _showSosSheet(context),
    onTap: () => context.go(Routes.emergency),
  ),
),
const SizedBox(width: 10),
Expanded(
  child: _QuickAction(
    icon: Icons.article_outlined,
    label: l.articles,  
    color: const Color(0xFF7C3AED),
    onTap: () => context.go(Routes.articles),
  ),
),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Specialties Section
                  _SectionHeader(
                    title: l.specialties,
                    seeAllLabel: l.seeAll,
                    onSeeAll: () => context.go(Routes.doctors),
                  ),
                  const SizedBox(height: 12),
                  _SpecialtiesList(),
                  const SizedBox(height: 28),

                  // Top Doctors Section
                  _SectionHeader(
                    title: l.topDoctors,
                    seeAllLabel: l.seeAll,
                    onSeeAll: () => context.go(Routes.doctors),
                  ),
                  const SizedBox(height: 12),
                  _TopDoctorsList(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  String _getGreeting(AppLocalizations l) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l.good_morning;
    if (hour < 17) return l.good_afternoon;
    return l.good_evening;
  }
}


// Next Appointment Banner


class _NextAppointmentBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final next = ref.watch(nextAppointmentProvider);

    return next.when(
      loading: () => const ShimmerCard(height: 100),
      error: (_, __) => const SizedBox.shrink(),
      data: (appt) {
        if (appt == null) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.noUpcomingAppointments,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  l.bookYourFirst,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          );
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.nextAppointment,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dr. ${appt.doctorName}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('EEE, dd MMM · HH:mm').format(appt.dateTime),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: appt.doctorAvatarUrl,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  width: 56,
                  height: 56,
                  color: Colors.white24,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}


// SOS Button


class _SosButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => _showSosSheet(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFDC2626).withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emergency_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l.sosNeedHelpNow,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              l.sosTapToFindDoctor, 
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void _showSosSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     builder: (_) => const _SosBottomSheet(),
//   );
// }
void _showSosSheet(BuildContext context) {
  // Сохраняем внешний context ДО открытия bottom sheet
  final rootContext = context;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _SosBottomSheet(rootContext: rootContext),
  );
}


// SOS Bottom Sheet


// class _SosBottomSheet extends StatelessWidget {
//   const _SosBottomSheet();

//   static const _doctors = [
//     {
//       'name': 'Dr. Sarah Johnson',
//       'specialty': 'General Practitioner',
//       'distance': '0.8 km',
//       'eta': '~10 min',
//       'rating': '4.9',
//     },
//     {
//       'name': 'Dr. Michael Chen',
//       'specialty': 'Emergency Medicine',
//       'distance': '1.2 km',
//       'eta': '~15 min',
//       'rating': '4.8',
//     },
//     {
//       'name': 'Dr. Aisha Bekova',
//       'specialty': 'Therapist',
//       'distance': '2.1 km',
//       'eta': '~20 min',
//       'rating': '4.7',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context)!;

//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: AppColors.neutral200,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           Row(
//             children: [
//               Container(
//                 width: 44,
//                 height: 44,
//                 decoration: BoxDecoration(
//                   color: AppColors.error.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.emergency_rounded,
//                     color: AppColors.error, size: 22),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     l.doctorsAvailableNow, 
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleMedium
//                         ?.copyWith(fontWeight: FontWeight.w700),
//                   ),
//                   Text(
//                     l.callDoctorToLocation,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodySmall
//                         ?.copyWith(color: AppColors.neutral400),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),

//           GestureDetector(
//             onTap: () {
//               final callAmbulanceTitle = l.callAmbulance;
//               final dial103Message = l.dial103ForEmergency;
//               final okLabel = l.ok;
//               Navigator.pop(context);
//               showDialog(
//                 context: context,
//                 builder: (_) => AlertDialog(
//                   title: Text(l.callAmbulance), 
//                   content: Text(l.dial103ForEmergency), 
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: Text(l.ok), 
//                     ),
//                   ],
//                 ),
//               );
//             },
//             child: Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(vertical: 12),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               decoration: BoxDecoration(
//                 color: AppColors.error.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: AppColors.error.withOpacity(0.3)),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.local_hospital_outlined,
//                       color: AppColors.error, size: 20),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       l.lifeThreatening103,
//                       style: TextStyle(
//                         color: AppColors.error,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                   const Icon(Icons.arrow_forward_ios,
//                       color: AppColors.error, size: 12),
//                 ],
//               ),
//             ),
//           ),

//           ..._doctors.map((doc) => _DoctorSosCard(doctor: doc)),
//         ],
//       ),
//     );
//   }
// }

class _SosBottomSheet extends StatelessWidget {
  final BuildContext rootContext;
  const _SosBottomSheet({required this.rootContext});

  static const _doctors = [
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'General Practitioner',
      'distance': '0.8 km',
      'eta': '~10 min',
      'rating': '4.9',
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Emergency Medicine',
      'distance': '1.2 km',
      'eta': '~15 min',
      'rating': '4.8',
    },
    {
      'name': 'Dr. Aisha Bekova',
      'specialty': 'Therapist',
      'distance': '2.1 km',
      'eta': '~20 min',
      'rating': '4.7',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.emergency_rounded,
                    color: AppColors.error, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.doctorsAvailableNow,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      l.callDoctorToLocation,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.neutral400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          GestureDetector(
            // onTap: () {
            
            //   final callAmbulanceTitle = l.callAmbulance;
            //   final dial103Message = l.dial103ForEmergency;
            //   final okLabel = l.ok;

            //   Navigator.pop(context);

            //   showDialog(
            //     context: context,
            //     builder: (_) => AlertDialog(
            //       title: Text(callAmbulanceTitle),
            //       content: Text(dial103Message),
            //       actions: [
            //         TextButton(
            //           onPressed: () => Navigator.pop(context),
            //           child: Text(okLabel),
            //         ),
            //       ],
            //     ),
            //   );
            // },
            onTap: () {
  Navigator.pop(context);
  launchUrl(Uri(scheme: 'tel', path: '103'));
},
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.error.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_hospital_outlined,
                      color: AppColors.error, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l.lifeThreatening103,
                      style: const TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      color: AppColors.error, size: 12),
                ],
              ),
            ),
          ),

          ..._doctors.map((doc) =>_DoctorSosCard(
                doctor: doc,
                rootContext: rootContext, 
              )),
        ],
      ),
    );
  }
}

// class _DoctorSosCard extends StatelessWidget {
//   final Map<String, dynamic> doctor;
//   // const _DoctorSosCard({required this.doctor});
//   final BuildContext rootContext; 

//   @override
//   Widget build(BuildContext context) {
//     final l = AppLocalizations.of(context)!;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.neutral200),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: const BoxDecoration(
//               color: AppColors.primaryContainer,
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.person_rounded,
//                 color: AppColors.primary, size: 26),
//           ),
//           const SizedBox(width: 12),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   doctor['name'] as String,
//                   style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   doctor['specialty'] as String,
//                   style: const TextStyle(
//                       color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.near_me_outlined,
//                         size: 12, color: AppColors.neutral400),
//                     const SizedBox(width: 3),
//                     Text('${doctor['distance']}',
//                         style: const TextStyle(fontSize: 11, color: AppColors.neutral400)),
//                     const SizedBox(width: 10),
//                     const Icon(Icons.access_time_outlined,
//                         size: 12, color: AppColors.neutral400),
//                     const SizedBox(width: 3),
//                     Text('ETA ${doctor['eta']}',
//                         style: const TextStyle(fontSize: 11, color: AppColors.neutral400)),
//                     const SizedBox(width: 10),
//                     const Icon(Icons.star_rounded, size: 12, color: Color(0xFFF59E0B)),
//                     const SizedBox(width: 2),
//                     Text('${doctor['rating']}',
//                         style: const TextStyle(fontSize: 11, color: AppColors.neutral400)),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(l.callingDoctorToLocation(doctor['name'] as String)),
//                   backgroundColor: AppColors.primary,
//                   duration: const Duration(seconds: 3),
//                   action: SnackBarAction(
//                     label: l.cancel,
//                     textColor: Colors.white,
//                     onPressed: () {},
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//               decoration: BoxDecoration(
//                 color: AppColors.primary,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 children: [
//                   Icon(Icons.call_rounded, color: Colors.white, size: 18),
//                   SizedBox(height: 2),
//                   Text(
//                     l.call,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _DoctorSosCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final BuildContext rootContext;

  const _DoctorSosCard({
    required this.doctor,
    required this.rootContext,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_rounded,
                color: AppColors.primary, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor['name'] as String,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  doctor['specialty'] as String,
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.near_me_outlined,
                        size: 12, color: AppColors.neutral400),
                    const SizedBox(width: 3),
                    Text('${doctor['distance']}',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.neutral400)),
                    const SizedBox(width: 10),
                    const Icon(Icons.access_time_outlined,
                        size: 12, color: AppColors.neutral400),
                    const SizedBox(width: 3),
                    Text('ETA ${doctor['eta']}',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.neutral400)),
                    const SizedBox(width: 10),
                    const Icon(Icons.star_rounded,
                        size: 12, color: Color(0xFFF59E0B)),
                    const SizedBox(width: 2),
                    Text('${doctor['rating']}',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.neutral400)),
                  ],
                ),
              ],
            ),
          ),

          // ── Call button → открывает CallScreen ────────────
          GestureDetector(
            // onTap: () {
            //   Navigator.pop(context); // закрываем bottom sheet

            //   // Используем rootContext — он активен
            //   Navigator.push(
            //     rootContext,
            //     MaterialPageRoute(
            //       builder: (_) => CallScreen(
            //         doctorName: doctor['name'] as String,
            //         doctorAvatarUrl: '',
            //         doctorSpecialty: doctor['specialty'] as String,
            //         isVideo: false,
            //       ),
            //     ),
            //   );
            // },
            onTap: () {
  // Сначала сохраняем navigator ДО закрытия sheet
  final nav = Navigator.of(rootContext);
  Navigator.pop(context);
  nav.push(
    MaterialPageRoute(
      builder: (_) => CallScreen(
        doctorName: doctor['name'] as String,
        doctorAvatarUrl: '',
        doctorSpecialty: doctor['specialty'] as String,
        isVideo: false,
      ),
    ),
  );
},
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.call_rounded,
                      color: Colors.white, size: 18),
                  const SizedBox(height: 2),
                  Text(
                    l.call,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Quick Actions


class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
          ),
        ]),
      ),
    );
  }
}


// Specialties List


class _SpecialtiesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: SpecialtyMapper.all.length,
        itemBuilder: (_, i) {
          final englishSpecialty = SpecialtyMapper.all[i];
          final translatedLabel = SpecialtyMapper.translate(englishSpecialty, l);
          final icon = SpecialtyMapper.getIcon(englishSpecialty);
          final color = SpecialtyMapper.getColor(englishSpecialty);

          return _SpecialtyChip(
            label: translatedLabel,
            icon: icon,
            color: color,
            onTap: () {
              ref.read(selectedSpecialtyProvider.notifier).state = englishSpecialty;
              context.go(Routes.doctors);
            },
          );
        },
      ),
    );
  }
}

class _SpecialtyChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SpecialtyChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
      ),
    );
  }
}


// Section Header


class _SectionHeader extends StatelessWidget {
  final String title;
  final String seeAllLabel;
  final VoidCallback onSeeAll;

  const _SectionHeader({
    required this.title,
    required this.seeAllLabel,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
              foregroundColor: AppColors.primary, padding: EdgeInsets.zero),
          child: Text(seeAllLabel),
        ),
      ],
    );
  }
}


// Top Doctors List


class _TopDoctorsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final docs = ref.watch(allDoctorsProvider);

    return docs.when(
      loading: () => SizedBox(
        height: 160,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(4, (_) => const ShimmerCard(height: 160)),
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (list) => SizedBox(
        height: 160,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.take(6).length,
          itemBuilder: (_, i) {
            final d = list[i];
            final translatedSpecialty = SpecialtyMapper.translate(d.specialty, l);

            return GestureDetector(
              onTap: () => context.push(
                '/doctors/${d.id}',
                extra: {
                  'name': d.name,
                  'specialty': d.specialty,
                  'avatarUrl': d.avatarUrl,
                  'rating': d.rating,
                  'reviewCount': d.reviewCount,
                  'experienceYears': d.experienceYears,
                  'consultationFee': d.consultationFee,
                  'about': d.about,
                  'isAvailable': d.isAvailable,
                },
              ),
              child: Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.neutral200),
                ),
                child: Column(children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(14)),
                    child: CachedNetworkImage(
                      imageUrl: d.avatarUrl,
                      height: 80,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        height: 80,
                        color: AppColors.primaryContainer,
                        child: const Icon(Icons.person, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      Text(
                        d.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        translatedSpecialty,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10, color: AppColors.primary),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Color(0xFFF59E0B), size: 12),
                          const SizedBox(width: 2),
                          Text(
                            d.rating.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}