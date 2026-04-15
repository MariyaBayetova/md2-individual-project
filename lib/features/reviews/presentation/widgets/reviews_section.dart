import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/review_providers.dart';

class ReviewsSection extends ConsumerStatefulWidget {
  final String doctorId;
  final String doctorName;
  const ReviewsSection({
    super.key,
    required this.doctorId,
    required this.doctorName,
  });

  @override
  ConsumerState<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends ConsumerState<ReviewsSection> {
  bool _showForm = false;
  double _selectedRating = 5;
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reviews = ref.watch(reviewsStreamProvider(widget.doctorId));
    final addState = ref.watch(addReviewProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Patient Reviews',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            TextButton.icon(
              onPressed: () => setState(() => _showForm = !_showForm),
              icon: Icon(
                _showForm ? Icons.close : Icons.rate_review_outlined,
                size: 16,
              ),
              label: Text(_showForm ? 'Cancel' : 'Write Review'),
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary),
            ),
          ],
        ),

        // Review form
        if (_showForm) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rate Dr. ${widget.doctorName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                // Star rating
                Row(
                  children: List.generate(5, (i) {
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedRating = i + 1.0),
                      child: Icon(
                        i < _selectedRating
                            ? Icons.star_rounded
                            : Icons.star_outline_rounded,
                        color: const Color(0xFFF59E0B),
                        size: 32,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Share your experience...',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addState.isLoading
                        ? null
                        : () async {
                            if (_commentController.text.trim().isEmpty) {
                              return;
                            }
                            await ref
                                .read(addReviewProvider.notifier)
                                .submit(
                                  doctorId: widget.doctorId,
                                  rating: _selectedRating,
                                  comment: _commentController.text.trim(),
                                );
                            if (!mounted) return;
                            _commentController.clear();
                            setState(() {
                              _showForm = false;
                              _selectedRating = 5;
                            });
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Review submitted!'),
                                backgroundColor: AppColors.success,
                              ),
                            );
                          },
                    child: addState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white))
                        : const Text('Submit Review'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Reviews list
        reviews.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (e, _) => const SizedBox.shrink(),
          data: (list) => list.isEmpty
              ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.neutral100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'No reviews yet. Be the first to review!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.neutral400),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.take(5).length,
                  itemBuilder: (_, i) => _ReviewCard(review: list[i]),
                ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final dynamic review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primaryContainer,
                child: Text(
                  review.userName.isNotEmpty
                      ? review.userName[0].toUpperCase()
                      : 'A',
                  style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 13),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  review.userName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < review.rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: const Color(0xFFF59E0B),
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            review.comment,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.neutral600, height: 1.4),
          ),
        ],
      ),
    );
  }
}
