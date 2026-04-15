import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/emergency_providers.dart';
import '../widgets/hospital_card.dart';

Future<void> _callNumber(String number) async {
  final uri = Uri(scheme: 'tel', path: number);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

class AmbulanceScreen extends ConsumerStatefulWidget {
  const AmbulanceScreen({super.key});

  @override
  ConsumerState<AmbulanceScreen> createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends ConsumerState<AmbulanceScreen> {
  String _filter = 'all';
  final _filters = ['all', 'hospital', 'clinic', 'emergency'];
  final _labels = ['All', 'Hospital', 'Clinic', 'Emergency'];

  @override
  Widget build(BuildContext context) {
    final hospitalsAsync = ref.watch(hospitalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency & Hospitals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () => context.push(Routes.hospitalMap),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SOS card — now a separate widget
          const _SosCard(),
          const SizedBox(height: 8),

          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: List.generate(_filters.length, (i) {
                final isSelected = _filters[i] == _filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Material(
                    color: isSelected
                        ? AppColors.primaryContainer
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => setState(() => _filter = _filters[i]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.neutral200,
                          ),
                        ),
                        child: Text(
                          _labels[i],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.neutral600,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),

          // Hospital list
          Expanded(
            child: hospitalsAsync.when(
              loading: () =>
                  const ShimmerList(count: 4, itemHeight: 120),
              error: (e, _) =>
                  ErrorView(message: 'Could not load hospitals.\n$e'),
              data: (list) {
                final filtered = _filter == 'all'
                    ? list
                    : list.where((h) => h.type == _filter).toList();
                return filtered.isEmpty
                    ? const EmptyView(
                        message: 'No results for this filter.',
                        icon: Icons.local_hospital_outlined,
                      )
                    : ListView.builder(
                        padding:
                            const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) =>
                            HospitalCard(hospital: filtered[index]),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── SOS Card — separate StatelessWidget so context is clean ──────────────────
class _SosCard extends StatelessWidget {
  const _SosCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need Emergency Help?',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Call 103 for an ambulance immediately',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: ElevatedButton.icon(
              // onPressed: () async {
              //   final uri = Uri(scheme: 'tel', path: '103');
              //   if (await canLaunchUrl(uri)) {
              //     await launchUrl(uri);
              //   }
              // },
              onPressed: () async {
                launchUrl(Uri(scheme: 'tel', path: '103'));
              },
              icon: const Icon(Icons.call, size: 16),
              label: const Text('Call 103'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.error,
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
