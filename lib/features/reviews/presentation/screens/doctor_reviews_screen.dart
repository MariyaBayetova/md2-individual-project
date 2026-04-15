import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/review_providers.dart';

class DoctorReviewsScreen extends ConsumerWidget {
  final String doctorId;
  final String doctorName;

  const DoctorReviewsScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewsStreamProvider(doctorId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Dr. $doctorName Reviews'),
      ),
      body: reviews.when(
        loading: () => const ShimmerList(count: 4, itemHeight: 100),
        error: (e, _) => ErrorView(
          message: 'Could not load reviews.\n$e',
        ),
        data: (list) => list.isEmpty
            ? const EmptyView(
                message: 'No reviews yet.\nBe the first to review this doctor!',
                icon: Icons.rate_review_outlined,
              )
            : Column(
                children: [
                  // Summary bar
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: AppColors.primaryContainer,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _avgRating(list).toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                            Row(
                              children: List.generate(5, (i) {
                                final avg = _avgRating(list);
                                return Icon(
                                  i < avg
                                      ? Icons.star_rounded
                                      : Icons.star_outline_rounded,
                                  color: const Color(0xFFF59E0B),
                                  size: 18,
                                );
                              }),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${list.length} review${list.length == 1 ? '' : 's'}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.neutral600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            children: [5, 4, 3, 2, 1].map((star) {
                              final count = list
                                  .where((r) => r.rating.round() == star)
                                  .length;
                              final pct = list.isEmpty
                                  ? 0.0
                                  : count / list.length;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    Text('$star',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.neutral600)),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.star_rounded,
                                        size: 11,
                                        color: Color(0xFFF59E0B)),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: pct,
                                          backgroundColor:
                                              AppColors.neutral200,
                                          valueColor:
                                              const AlwaysStoppedAnimation(
                                                  AppColors.primary),
                                          minHeight: 6,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text('$count',
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.neutral400)),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Reviews list
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final r = list[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            border:
                                Border.all(color: AppColors.neutral200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18,
                                    backgroundColor:
                                        AppColors.primaryContainer,
                                    child: Text(
                                      r.userName.isNotEmpty
                                          ? r.userName[0].toUpperCase()
                                          : 'A',
                                      style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          r.userName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontWeight:
                                                      FontWeight.w600),
                                        ),
                                        Text(
                                          _formatDate(r.createdAt),
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.neutral400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (i) => Icon(
                                        i < r.rating
                                            ? Icons.star_rounded
                                            : Icons.star_outline_rounded,
                                        color: const Color(0xFFF59E0B),
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                r.comment,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.neutral600,
                                      height: 1.5,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  double _avgRating(List list) {
    if (list.isEmpty) return 0;
    return list.fold(0.0, (sum, r) => sum + r.rating) / list.length;
  }

  String _formatDate(DateTime dt) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }
}
