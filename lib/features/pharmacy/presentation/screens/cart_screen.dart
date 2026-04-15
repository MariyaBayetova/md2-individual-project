import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/pharmacy_providers.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final items = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: () => ref.read(cartProvider.notifier).clear(),
              child: const Text('Clear'),
            ),
        ],
      ),
      body: items.isEmpty
          ? const EmptyView(
              message: 'Your cart is empty.\nBrowse pharmacy to add items.',
              icon: Icons.shopping_cart_outlined,
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.neutral200,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icon
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.medication_rounded,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.drug.brandName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${item.drug.price.toStringAsFixed(0)} ${l.currency} each',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppColors.neutral400),
                                  ),
                                ],
                              ),
                            ),
                            // Quantity control
                            Row(
                              children: [
                                _QtyButton(
                                  icon: Icons.remove,
                                  onTap: () => ref
                                      .read(cartProvider.notifier)
                                      .decrementItem(item.drug.id),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    '${item.quantity}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700),
                                  ),
                                ),
                                _QtyButton(
                                  icon: Icons.add,
                                  onTap: () => ref
                                      .read(cartProvider.notifier)
                                      .addItem(item.drug),
                                  filled: true,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Payment summary + checkout
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _SummaryRow(label: 'Subtotal', value: total),
                      const SizedBox(height: 6),
                      _SummaryRow(label: 'Taxes (12%)', value: total * 0.12),
                      const Divider(height: 20),
                      _SummaryRow(
                        label: 'Total',
                        value: total + total * 0.12,
                        isBold: true,
                      ),
                      const SizedBox(height: 16),
                      AppButton(
                        label:
                            'Checkout  ${(total + total * 0.12).toStringAsFixed(0)} ${l.currency}',
                        onPressed: () => context.push(Routes.checkout),
                        icon: Icons.payment_outlined,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: filled ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
          fontSize: isBold ? 16 : null,
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('${value.toStringAsFixed(0)} ${l.currency}', style: style),
      ],
    );
  }
}
