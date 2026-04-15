// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:medical_appointment_app/l10n/app_localizations.dart';
// import '../../../../core/router/app_router.dart';
// import '../../../../core/theme/app_colors.dart';
// import '../../../../core/widgets/app_button.dart';

// class DoctorDetailScreen extends ConsumerWidget {
//   final String doctorId;
//   final Map<String, dynamic>? extra;

//   const DoctorDetailScreen({
//     super.key,
//     required this.doctorId,
//     this.extra,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final l = AppLocalizations.of(context)!;
//     final d = extra ?? {};
//     final name = d['name'] as String? ?? '';
//     final specialty = d['specialty'] as String? ?? '';
//     final avatarUrl = d['avatarUrl'] as String? ?? '';
//     final rating = (d['rating'] as num?)?.toDouble() ?? 0;
//     final reviewCount = d['reviewCount'] as int? ?? 0;
//     final experienceYears = d['experienceYears'] as int? ?? 0;
//     final fee = (d['consultationFee'] as num?)?.toDouble() ?? 0;
//     final about = d['about'] as String? ?? '';
//     final isAvailable = d['isAvailable'] as bool? ?? true;

//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 280,
//             pinned: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   Hero(
//                     tag: 'doctor-$doctorId',
//                     child: CachedNetworkImage(
//                       imageUrl: avatarUrl,
//                       fit: BoxFit.cover,
//                       errorWidget: (_, __, ___) => Container(
//                         color: AppColors.primaryContainer,
//                         child: const Icon(Icons.person,
//                             size: 80, color: AppColors.primary),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [Colors.transparent, Colors.black54],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 16,
//                     left: 16,
//                     right: 16,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Dr. $name',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 22,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           specialty,
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.85),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       _StatCard(
//                         icon: Icons.star_rounded,
//                         iconColor: const Color(0xFFF59E0B),
//                         value: rating.toStringAsFixed(1),
//                         label: l.rating,
//                       ),
//                       const SizedBox(width: 12),
//                       _StatCard(
//                         icon: Icons.people_outline,
//                         iconColor: AppColors.primary,
//                         value: '$reviewCount',
//                         label: l.reviews,
//                       ),
//                       const SizedBox(width: 12),
//                       _StatCard(
//                         icon: Icons.work_outline,
//                         iconColor: AppColors.info,
//                         value: '$experienceYears ${l.experience}',
//                         label: l.experienceLabel,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     l.about,
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleMedium
//                         ?.copyWith(fontWeight: FontWeight.w700),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     about,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(color: AppColors.neutral600, height: 1.5),
//                   ),
//                   const SizedBox(height: 24),
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryContainer,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.payments_outlined,
//                             color: AppColors.primary),
//                         const SizedBox(width: 12),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               l.consultationFee,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelSmall
//                                   ?.copyWith(color: AppColors.neutral600),
//                             ),
//                             Text(
//                               '${fee.toStringAsFixed(0)} ${AppLocalizations.of(context)!.currency}',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .titleMedium
//                                   ?.copyWith(
//                                     color: AppColors.primary,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   AppButton(
//                     label: isAvailable
//                         ? l.bookAppointment
//                         : l.busy,
//                     onPressed: isAvailable
//                         ? () => context.push(
//                               Routes.booking,
//                               extra: {
//                                 'doctorId': doctorId,
//                                 'doctorName': name,
//                                 'specialty': specialty,
//                                 'fee': fee,
//                                 'avatarUrl': avatarUrl,
//                               },
//                             )
//                         : null,
//                     icon: Icons.calendar_today_outlined,
//                   ),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final String value;
//   final String label;

//   const _StatCard({
//     required this.icon,
//     required this.iconColor,
//     required this.value,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.neutral200),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: iconColor, size: 22),
//             const SizedBox(height: 4),
//             Text(
//               value,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleSmall
//                   ?.copyWith(fontWeight: FontWeight.w700),
//             ),
//             Text(
//               label,
//               style: Theme.of(context)
//                   .textTheme
//                   .labelSmall
//                   ?.copyWith(color: AppColors.neutral400),
//             ),
//           ],
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
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/specialty_mapper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../chat/presentation/providers/chat_providers.dart';
import '../../../reviews/presentation/widgets/reviews_section.dart';

class DoctorDetailScreen extends ConsumerWidget {
  final String doctorId;
  final Map<String, dynamic>? extra;

  const DoctorDetailScreen({
    super.key,
    required this.doctorId,
    this.extra,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final d = extra ?? {};
    final name = d['name'] as String? ?? '';
    final specialty = d['specialty'] as String? ?? '';
    final avatarUrl = d['avatarUrl'] as String? ?? '';
    final rating = (d['rating'] as num?)?.toDouble() ?? 0;
    final reviewCount = d['reviewCount'] as int? ?? 0;
    final experienceYears = d['experienceYears'] as int? ?? 0;
    final fee = (d['consultationFee'] as num?)?.toDouble() ?? 0;
    final about = d['about'] as String? ?? '';
    final isAvailable = d['isAvailable'] as bool? ?? true;

    // Перевод специальности
    final translatedSpecialty = SpecialtyMapper.translate(specialty, l);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
         
          // Expandable Header
         
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'doctor-$doctorId',
                    child: CachedNetworkImage(
                      imageUrl: avatarUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        color: AppColors.primaryContainer,
                        child: const Icon(Icons.person,
                            size: 80, color: AppColors.primary),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. $name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          translatedSpecialty,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

         
          // Content
         
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.star_rounded,
                        iconColor: const Color(0xFFF59E0B),
                        value: rating.toStringAsFixed(1),
                        label: l.rating,
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () => context.push(
                          Routes.doctorReviews,
                          extra: {
                            'doctorId': doctorId,
                            'doctorName': name,
                          },
                        ),
                        child: _StatCard(
                          icon: Icons.people_outline,
                          iconColor: AppColors.primary,
                          value: '$reviewCount',
                          label: l.reviews,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.work_outline,
                        iconColor: AppColors.info,
                        value: '$experienceYears ${l.experience}',
                        label: l.experienceLabel,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // About Section
                  Text(
                    l.about,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    about,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.neutral600, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Consultation Fee
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.payments_outlined,
                            color: AppColors.primary),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.consultationFee,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppColors.neutral600),
                            ),
                            Text(
                              '${fee.toStringAsFixed(0)} ${l.currency}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Chat Button (NEW)
                  AppButton(
                    label: l.chatWithDoctor,
                    outlined: true,
                    icon: Icons.chat_bubble_outline,
                    onPressed: () async {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l.pleaseSignIn)),
                        );
                        return;
                      }

                      final params = {
                        'doctorId': doctorId,
                        'doctorName': name,
                        'doctorAvatarUrl': avatarUrl,
                        'doctorSpecialty': specialty,
                      };

                      final conversationId = await ref
                          .read(conversationIdProvider(params).future);

                      if (context.mounted) {
                        context.push(Routes.chatRoom, extra: {
                          'conversationId': conversationId,
                          'doctorName': name,
                          'doctorAvatarUrl': avatarUrl,
                          'doctorSpecialty': translatedSpecialty,
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 12),

                  // Book Appointment Button
                  AppButton(
                    label: isAvailable ? l.bookAppointment : l.notAvailable,
                    onPressed: isAvailable
                        ? () => context.push(
                              Routes.booking,
                              extra: {
                                'doctorId': doctorId,
                                'doctorName': name,
                                'specialty': specialty,
                                'fee': fee,
                                'avatarUrl': avatarUrl,
                                'about': about,
              'rating': rating,
              'experienceYears': experienceYears,
              'reviewCount': reviewCount,
                              },
                            )
                        : null,
                    icon: Icons.calendar_today_outlined,
                  ),
                  const SizedBox(height: 24),

                  // Reviews Section (NEW)
                  ReviewsSection(
                    doctorId: doctorId,
                    doctorName: name,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Stat Card


class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.neutral400),
            ),
          ],
        ),
      ),
    );
  }
}