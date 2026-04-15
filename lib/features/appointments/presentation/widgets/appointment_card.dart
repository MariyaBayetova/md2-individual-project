import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/appointment_entity.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;
  final VoidCallback? onCancel;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onCancel,
  });

  Color _statusColor(String status) => switch (status) {
        AppConstants.statusConfirmed => AppColors.confirmed,
        AppConstants.statusPending => AppColors.pending,
        AppConstants.statusCancelled => AppColors.cancelled,
        _ => AppColors.completed,
      };

  @override
  Widget build(BuildContext context) {
    final dateStr =
        DateFormat('EEE, dd MMM yyyy').format(appointment.dateTime);
    final timeStr = DateFormat('HH:mm').format(appointment.dateTime);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push(
          Routes.booking,
          extra: {
            'doctorId': appointment.doctorId,
            'doctorName': appointment.doctorName,
            'specialty': appointment.doctorSpecialty,
            'fee': appointment.fee,
            'avatarUrl': appointment.doctorAvatarUrl,
          },
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: appointment.doctorAvatarUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        width: 56,
                        height: 56,
                        color: AppColors.primaryContainer,
                        child: const Icon(Icons.person,
                            color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. ${appointment.doctorName}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          appointment.doctorSpecialty,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(appointment.status)
                          .withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      appointment.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _statusColor(appointment.status),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 15, color: AppColors.neutral400),
                  const SizedBox(width: 6),
                  Text(dateStr,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.neutral600)),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time,
                      size: 15, color: AppColors.neutral400),
                  const SizedBox(width: 6),
                  Text(timeStr,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.neutral600)),
                  const Spacer(),
                 
                  Row(
                    children: [
                      Text(
                        'Rebook',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.chevron_right,
                          size: 16, color: AppColors.primary),
                    ],
                  ),
                  if (appointment.isUpcoming &&
                      appointment.status !=
                          AppConstants.statusCancelled &&
                      onCancel != null)
                    TextButton(
                      onPressed: onCancel,
                      style: TextButton.styleFrom(
                          foregroundColor: AppColors.error,
                          padding: EdgeInsets.zero),
                      child: const Text('Cancel',
                          style: TextStyle(fontSize: 12)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}