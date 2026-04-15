import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review_model.dart';

abstract class ReviewDataSource {
  Stream<List<ReviewModel>> getReviews(String doctorId);
  Stream<List<ReviewModel>> getMyReviews(String userId);
  Future<void> addReview(ReviewModel review);
}

class ReviewDataSourceImpl implements ReviewDataSource {
  final FirebaseFirestore firestore;
  ReviewDataSourceImpl({required this.firestore});

  CollectionReference get _col => firestore.collection('reviews');

  @override
  Stream<List<ReviewModel>> getReviews(String doctorId) {
    return _col
        .where('doctorId', isEqualTo: doctorId)
        .snapshots()
        .map((s) =>
            s.docs.map((d) => ReviewModel.fromFirestore(d)).toList());
  }

  @override
  Stream<List<ReviewModel>> getMyReviews(String userId) {
    return _col
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((s) =>
            s.docs.map((d) => ReviewModel.fromFirestore(d)).toList());
  }

  @override
  Future<void> addReview(ReviewModel review) =>
      _col.add(review.toFirestore());
}
