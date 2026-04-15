import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/features/pharmacy/presentation/providers/pharmacy_providers.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class MainShell extends ConsumerWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(Routes.doctors)) return 1;
    if (location.startsWith(Routes.appointments)) return 2;
    if (location.startsWith(Routes.pharmacy)) return 3;
    if (location.startsWith(Routes.patientCard)) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = _currentIndex(context);
    final l = AppLocalizations.of(context)!;
    final cartCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          switch (i) {
            case 0: context.go(Routes.home); break;
            case 1: context.go(Routes.doctors); break;
            case 2: context.go(Routes.appointments); break;
            case 3: context.go(Routes.pharmacy); break;
            case 4: context.go(Routes.patientCard); break;
          }
        },
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: AppColors.primaryContainer,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon:
                const Icon(Icons.home_rounded, color: AppColors.primary),
            label: l.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.search_outlined),
            selectedIcon: const Icon(Icons.search, color: AppColors.primary),
            label: l.doctors,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_today_outlined),
            selectedIcon:
                const Icon(Icons.calendar_today, color: AppColors.primary),
            label: l.appointments,
          ),
                    NavigationDestination(
            icon: cartCount > 0
                ? Badge(
                    label: Text('$cartCount'),
                    child: const Icon(Icons.medication_outlined),
                  )
                : const Icon(Icons.medication_outlined),
            selectedIcon:
                const Icon(Icons.medication, color: AppColors.primary),
            label: l.pharmacy,
          ),

          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person, color: AppColors.primary),
            label: l.profile,
          ),
        ],
      ),
    );
  }
}