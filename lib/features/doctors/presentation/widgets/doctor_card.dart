import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/doctor_entity.dart';

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;
  final VoidCallback onTap;

  const DoctorCard({super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Avatar
              Hero(
                tag: 'doctor-${doctor.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: doctor.avatarUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: AppColors.neutral200,
                      child: const Icon(Icons.person, color: AppColors.neutral400),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: AppColors.primaryContainer,
                      child: const Icon(Icons.person, color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. ${doctor.name}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialty,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.primary),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFF59E0B), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          doctor.rating.toStringAsFixed(1),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${doctor.reviewCount})',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppColors.neutral400),
                        ),
                        const Spacer(),
                        Text(
                          '${doctor.experienceYears} yr',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppColors.neutral600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: doctor.isAvailable
                      ? AppColors.primaryContainer
                      : AppColors.neutral100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  doctor.isAvailable ? 'Available' : 'Busy',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: doctor.isAvailable
                        ? AppColors.primary
                        : AppColors.neutral400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
