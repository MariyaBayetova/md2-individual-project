import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/hospital_entity.dart';

Future<void> _callNumber(String number) async {
  final uri = Uri(scheme: 'tel', path: number);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

class HospitalCard extends StatelessWidget {
  final HospitalEntity hospital;
  const HospitalCard({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: hospital.hasEmergency
                      ? AppColors.error.withValues(alpha: 0.1)
                      : AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  hospital.hasEmergency
                      ? Icons.emergency_outlined
                      : Icons.local_hospital_outlined,
                  color: hospital.hasEmergency
                      ? AppColors.error
                      : AppColors.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hospital.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      hospital.address,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.neutral600),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            size: 12, color: Color(0xFFF59E0B)),
                        const SizedBox(width: 2),
                        Text(hospital.rating.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.neutral400)),
                        const SizedBox(width: 8),
                        const Icon(Icons.near_me_outlined,
                            size: 12, color: AppColors.neutral400),
                        const SizedBox(width: 2),
                        Text(hospital.distance,
                            style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.neutral400)),
                        if (hospital.isOpen24h) ...[
                          const SizedBox(width: 8),
                          _Badge(label: '24h', color: AppColors.success),
                        ],
                        if (hospital.hasEmergency) ...[
                          const SizedBox(width: 6),
                          _Badge(label: 'SOS', color: AppColors.error),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Call button — full width tappable container
          Material(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => _callNumber(hospital.phone),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 11, horizontal: 14),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Icon(Icons.call_outlined,
                        size: 16, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Call ${hospital.phone}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 9, color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
