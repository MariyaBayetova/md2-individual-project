import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/pharmacy_providers.dart';
import '../widgets/drug_card.dart';

class PharmacyScreen extends ConsumerWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drugs = ref.watch(displayedDrugsProvider);
    final cartCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy'),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => context.push(Routes.cart),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(),
          // Medicine reminders shortcut
          GestureDetector(
            onTap: () => context.push(Routes.reminders),
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.alarm_outlined, color: AppColors.warning, size: 18),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Set medicine reminders for your prescriptions',
                      style: TextStyle(fontSize: 12, color: AppColors.warning, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: AppColors.warning, size: 12),
                ],
              ),
            ),
          ),
          Expanded(
            child: drugs.when(
              loading: () => const ShimmerList(count: 6, itemHeight: 120),
              error: (e, _) => ErrorView(
                message: 'Could not load drugs.\n$e',
                onRetry: () => ref.invalidate(popularDrugsProvider),
              ),
              data: (list) => list.isEmpty
                  ? const EmptyView(
                      message: 'No results found.\nTry a different search.',
                      icon: Icons.medication_outlined,
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: list.length,
                      itemBuilder: (context, index) =>
                          DrugCard(drug: list[index]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(drugSearchQueryProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: TextField(
        onChanged: (v) => ref.read(drugSearchQueryProvider.notifier).state = v,
        decoration: InputDecoration(
          hintText: 'Search drugs, category...',
          prefixIcon: const Icon(Icons.search, color: AppColors.neutral400),
          suffixIcon: query.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.neutral400),
                  onPressed: () =>
                      ref.read(drugSearchQueryProvider.notifier).state = '',
                )
              : null,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
