import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_appointment_app/features/appointments/domain/usecases/cancel_appointment_usecase.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/offline_banner.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/appointment_providers.dart';
import '../widgets/appointment_card.dart';

class AppointmentsScreen extends ConsumerStatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  ConsumerState<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends ConsumerState<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.myAppointments),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.neutral400,
          tabs: [
            Tab(text: l.upcoming),
            Tab(text: l.past),
          ],
        ),
      ),
      body: Column(
        children: [
          const OfflineBanner(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Upcoming
                Consumer(builder: (context, ref, _) {
                  final upcoming = ref.watch(upcomingAppointmentsProvider);
                  final l = AppLocalizations.of(context)!;
                  return upcoming.when(
                    loading: () => const ShimmerList(itemHeight: 120),
                    error: (e, _) => ErrorView(message: e.toString()),
                    data: (list) => list.isEmpty
                        ? EmptyView(
                            message: l.noUpcomingAppointments,
                            icon: Icons.event_available_outlined,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: list.length,
                            itemBuilder: (listContext, i) => AppointmentCard(
                              appointment: list[i],
                              onCancel: () async {
                                final l = AppLocalizations.of(listContext)!;
                                final confirm = await showDialog<bool>(
                                  context: listContext,
                                  builder: (dialogContext) => AlertDialog(
                                    title: Text(l.cancelAppointmentTitle),
                                    content: Text(l.cannotUndo),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(dialogContext, false),
                                        child: Text(l.no),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.error,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () =>
                                            Navigator.pop(dialogContext, true),
                                        child: Text(l.yesCancel),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirm == true && listContext.mounted) {
                                  await sl<CancelAppointmentUseCase>()
                                      .call(list[i].id);
                                }
                              },
                            ),
                          ),
                  );
                }),

                // Past
                Consumer(builder: (context, ref, _) {
                  final past = ref.watch(pastAppointmentsProvider);
                  final l = AppLocalizations.of(context)!;
                  return past.when(
                    loading: () => const ShimmerList(itemHeight: 120),
                    error: (e, _) => ErrorView(message: e.toString()),
                    data: (list) => list.isEmpty
                        ? EmptyView(
                            message: l.noPastAppointments,
                            icon: Icons.history,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: list.length,
                            itemBuilder: (_, i) =>
                                AppointmentCard(appointment: list[i]),
                          ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}