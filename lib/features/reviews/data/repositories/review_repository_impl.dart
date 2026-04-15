import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/review_repository.dart';
import '../datasources/review_datasource.dart';
import '../models/review_model.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewDataSource dataSource;
  ReviewRepositoryImpl({required this.dataSource});

  @override
  Stream<List<ReviewEntity>> getReviews(String doctorId) =>
      dataSource.getReviews(doctorId);

  @override
  Stream<List<ReviewEntity>> getMyReviews(String userId) =>
      dataSource.getMyReviews(userId);

  @override
  Future<void> addReview(ReviewEntity review) =>
      dataSource.addReview(ReviewModel(
        id: review.id,
        doctorId: review.doctorId,
        userId: review.userId,
        userName: review.userName,
        rating: review.rating,
        comment: review.comment,
        createdAt: review.createdAt,
      ));
}
