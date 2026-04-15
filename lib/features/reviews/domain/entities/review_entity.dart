import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String doctorId;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;

  const ReviewEntity({
    required this.id,
    required this.doctorId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id];
}
