import '../entities/review_entity.dart';

abstract class ReviewRepository {
  Stream<List<ReviewEntity>> getReviews(String doctorId);
  Stream<List<ReviewEntity>> getMyReviews(String userId);
  Future<void> addReview(ReviewEntity review);
}
