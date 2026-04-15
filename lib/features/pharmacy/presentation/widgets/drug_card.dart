import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_appointment_app/l10n/app_localizations.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/drug_entity.dart';
import '../providers/pharmacy_providers.dart';
import 'drug_image_widget.dart';

class DrugCard extends ConsumerWidget {
  final DrugEntity drug;
  const DrugCard({super.key, required this.drug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final cartItems = ref.watch(cartProvider);
    final inCart = cartItems.any((i) => i.drug.id == drug.id);

    return GestureDetector(
      onTap: () => context.push(Routes.drugDetail, extra: drug),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neutral200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: DrugImageWidget(
                      drugName: drug.genericName.isNotEmpty
                          ? drug.genericName
                          : drug.brandName,
                      dosageForm: drug.dosageForm,
                      size: 120,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                  ),
                  if (!drug.inStock)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Out of Stock',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Info area
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drug.brandName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 12, color: Color(0xFFF59E0B)),
                      const SizedBox(width: 2),
                      Text(
                        drug.rating.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.neutral400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${drug.price.toStringAsFixed(0)} ${l.currency}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      GestureDetector(
                        onTap: drug.inStock
                            ? () => ref
                                .read(cartProvider.notifier)
                                .addItem(drug)
                            : null,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: inCart
                                ? AppColors.primary
                                : AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            inCart ? Icons.check : Icons.add,
                            size: 16,
                            color: inCart ? Colors.white : AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
