import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.doctorId,
    required super.userId,
    required super.userName,
    required super.rating,
    required super.comment,
    required super.createdAt,
  });

  factory ReviewModel.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return ReviewModel(
      id: doc.id,
      doctorId: d['doctorId'] as String? ?? '',
      userId: d['userId'] as String? ?? '',
      userName: d['userName'] as String? ?? 'Anonymous',
      rating: (d['rating'] as num?)?.toDouble() ?? 5.0,
      comment: d['comment'] as String? ?? '',
      createdAt:
          (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
        'doctorId': doctorId,
        'userId': userId,
        'userName': userName,
        'rating': rating,
        'comment': comment,
        'createdAt': Timestamp.fromDate(createdAt),
      };
}
