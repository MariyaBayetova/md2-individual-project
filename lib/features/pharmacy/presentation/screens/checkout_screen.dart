import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../providers/pharmacy_providers.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedPayment = 'Visa';
  bool _isLoading = false;
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final total = ref.watch(cartTotalProvider);
    final grandTotal = total + total * 0.12;

    if (_success) return _SuccessView(total: grandTotal);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery address
            _SectionTitle(title: 'Delivery Address'),
            const SizedBox(height: 10),
            _AddressTile(
              address: '1640 Dashin Street, Astana',
              onEdit: () {},
            ),
            const SizedBox(height: 24),

            // Payment method
            _SectionTitle(title: 'Payment Method'),
            const SizedBox(height: 10),
            ..._paymentOptions(),
            const SizedBox(height: 24),

            // Order summary
            _SectionTitle(title: 'Order Summary'),
            const SizedBox(height: 10),
            _SummaryRow(label: 'Subtotal', value: total),
            const SizedBox(height: 6),
            _SummaryRow(label: 'Taxes (12%)', value: total * 0.12),
            const Divider(height: 20),
            _SummaryRow(
              label: 'Total',
              value: grandTotal,
              isBold: true,
            ),
            const SizedBox(height: 32),

            AppButton(
              label: 'Pay  ${grandTotal.toStringAsFixed(0)} ${l.currency}',
              isLoading: _isLoading,
              onPressed: _placeOrder,
              icon: Icons.lock_outline,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _paymentOptions() {
    final options = ['Visa', 'Mastercard', 'Cash on Delivery'];
    return options
        .map(
          (opt) => RadioListTile<String>(
            value: opt,
            groupValue: _selectedPayment,
            title: Text(opt),
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
            onChanged: (v) => setState(() => _selectedPayment = v!),
          ),
        )
        .toList();
  }

  Future<void> _placeOrder() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    ref.read(cartProvider.notifier).clear();
    setState(() {
      _isLoading = false;
      _success = true;
    });
  }
}

// ── Payment success overlay ──────────────────────────────────────────────────
class _SuccessView extends StatelessWidget {
  
  final double total;
  const _SuccessView({required this.total});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded,
                    color: AppColors.primary, size: 44),
              ),
              const SizedBox(height: 24),
              Text(
                'Payment Success',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Your payment of ${total.toStringAsFixed(0)} ${l.currency} was successful.\n'
                'You can track your order in the app.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.neutral600),
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Back to Home',
                onPressed: () => context.go(Routes.home),
                icon: Icons.home_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}

class _AddressTile extends StatelessWidget {
  final String address;
  final VoidCallback onEdit;
  const _AddressTile({required this.address, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(address,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
          TextButton(onPressed: onEdit, child: const Text('Edit')),
        ],
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
