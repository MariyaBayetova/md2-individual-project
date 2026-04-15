import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/emergency_providers.dart';

class HospitalMapScreen extends ConsumerWidget {
  const HospitalMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hospitals = ref.watch(hospitalsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hospitals Near You')),
      body: hospitals.when(
        loading: () => const ShimmerList(count: 4, itemHeight: 100),
        error: (e, _) => ErrorView(message: 'Could not load hospitals.\n$e'),
        data: (list) => Column(
          children: [
            // Real OpenStreetMap
            SizedBox(
              height: 280,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(51.1694, 71.4491),
                  initialZoom: 13,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName:
                        'com.example.medical_appointment_app',
                  ),
                  MarkerLayer(
                    markers: list
                        .map(
                          (h) => Marker(
                            point: LatLng(h.latitude, h.longitude),
                            width: 56,
                            height: 56,
                            child: GestureDetector(
                              onTap: () => _showSheet(context, h),
                              child: Column(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: h.hasEmergency
                                          ? AppColors.error
                                          : AppColors.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.2),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      h.hasEmergency
                                          ? Icons.emergency_outlined
                                          : Icons.local_hospital_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      h.distance,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.neutral900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            // Legend
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Theme.of(context).colorScheme.surface,
              child: Row(
                children: [
                  _LegendItem(color: AppColors.error, label: 'Emergency'),
                  const SizedBox(width: 16),
                  _LegendItem(
                      color: AppColors.primary,
                      label: 'Hospital / Clinic'),
                  const Spacer(),
                  const Icon(Icons.touch_app_outlined,
                      size: 14, color: AppColors.neutral400),
                  const SizedBox(width: 4),
                  const Text(
                    'Tap pin for details',
                    style: TextStyle(
                        fontSize: 11, color: AppColors.neutral400),
                  ),
                ],
              ),
            ),

            // Hospital list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final h = list[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 4),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: h.hasEmergency
                            ? AppColors.error.withValues(alpha: 0.1)
                            : AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        h.hasEmergency
                            ? Icons.emergency_outlined
                            : Icons.local_hospital_outlined,
                        size: 20,
                        color: h.hasEmergency
                            ? AppColors.error
                            : AppColors.primary,
                      ),
                    ),
                    title: Text(h.name,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    subtitle: Text(h.address,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.neutral400)),
                    trailing: Text(
                      h.distance,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.primary),
                    ),
                    onTap: () => _showSheet(context, h),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSheet(BuildContext context, dynamic hospital) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hospital.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.location_on_outlined,
                  size: 14, color: AppColors.neutral400),
              const SizedBox(width: 4),
              Expanded(
                child: Text(hospital.address,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.call_outlined,
                  size: 14, color: AppColors.neutral400),
              const SizedBox(width: 4),
              Text(hospital.phone,
                  style: Theme.of(context).textTheme.bodySmall),
            ]),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.directions_outlined),
                label: const Text('Get Directions'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
