import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/drug_entity.dart';
import '../providers/pharmacy_providers.dart';
import '../widgets/drug_image_widget.dart';

class DrugDetailScreen extends ConsumerWidget {
  final DrugEntity drug;
  const DrugDetailScreen({super.key, required this.drug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final cartItems = ref.watch(cartProvider);
    final inCart = cartItems.any((i) => i.drug.id == drug.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drug Detail'),
        actions: [
          IconButton(
            icon: Icon(
              inCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
              color: inCart ? AppColors.primary : null,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drug image — real photo from RxImage or fallback icon
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: DrugImageWidget(
                  drugName: drug.genericName.isNotEmpty
                      ? drug.genericName
                      : drug.brandName,
                  dosageForm: drug.dosageForm,
                  size: 180,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Name & rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        drug.brandName,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        drug.genericName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.neutral400),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFF59E0B), size: 18),
                    const SizedBox(width: 4),
                    Text(
                      drug.rating.toStringAsFixed(1),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Info chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(label: drug.dosageForm, icon: Icons.medication_outlined),
                _InfoChip(label: drug.route, icon: Icons.route_outlined),
                _InfoChip(
                  label: drug.inStock ? 'In Stock' : 'Out of Stock',
                  icon: drug.inStock
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  color: drug.inStock ? AppColors.success : AppColors.error,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Price
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.payments_outlined, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppColors.neutral600),
                      ),
                      Text(
                        '${drug.price.toStringAsFixed(0)} ${l.currency}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Purpose
            if (drug.purpose.isNotEmpty &&
                drug.purpose != 'See description') ...[
              _Section(
                title: 'Purpose',
                content: drug.purpose,
                context: context,
              ),
              const SizedBox(height: 16),
            ],

            // Description
            _Section(
              title: 'Description',
              content: drug.description,
              context: context,
            ),
            const SizedBox(height: 16),

            // Manufacturer
            Row(
              children: [
                const Icon(Icons.business_outlined,
                    size: 16, color: AppColors.neutral400),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Manufacturer: ${drug.manufacturer}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.neutral600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Add to cart
            AppButton(
              label: inCart ? 'Added to Cart ✓' : 'Add to Cart',
              onPressed: drug.inStock
                  ? () {
                      ref.read(cartProvider.notifier).addItem(drug);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('${drug.brandName} added to cart'),
                          backgroundColor: AppColors.primary,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  : null,
              icon: Icons.shopping_cart_outlined,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _InfoChip({
    required this.label,
    required this.icon,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String content;
  final BuildContext context;

  const _Section({
    required this.title,
    required this.content,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          content,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.neutral600, height: 1.5),
        ),
      ],
    );
  }
}
