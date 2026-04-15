import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/review_repository.dart';

// Reviews for a specific doctor
final reviewsStreamProvider =
    StreamProvider.family<List<ReviewEntity>, String>((ref, doctorId) {
  return sl<ReviewRepository>().getReviews(doctorId);
});

// My reviews
final myReviewsStreamProvider =
    StreamProvider<List<ReviewEntity>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return const Stream.empty();
  return sl<ReviewRepository>().getMyReviews(user.uid);
});

class AddReviewNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> submit({
    required String doctorId,
    required double rating,
    required String comment,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    state = const AsyncLoading();
    final review = ReviewEntity(
      id: '',
      doctorId: doctorId,
      userId: user.uid,
      userName: user.displayName ?? 'Anonymous',
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
    );
    state = await AsyncValue.guard(
      () => sl<ReviewRepository>().addReview(review),
    );
  }
}

final addReviewProvider =
    AsyncNotifierProvider<AddReviewNotifier, void>(AddReviewNotifier.new);
