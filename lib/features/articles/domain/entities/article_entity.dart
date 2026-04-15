import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String id;
  final String title;
  final String summary;
  final String category;
  final String readTime;
  final String imageTag; // emoji used as visual placeholder

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
    required this.readTime,
    required this.imageTag,
  });

  @override
  List<Object?> get props => [id];
}
