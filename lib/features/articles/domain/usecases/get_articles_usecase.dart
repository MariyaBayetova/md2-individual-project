import '../entities/article_entity.dart';
import '../repositories/article_repository.dart';

class GetArticlesUseCase {
  final ArticleRepository repository;
  GetArticlesUseCase(this.repository);

  Future<List<ArticleEntity>> call({String? category}) =>
      repository.getArticles(category: category);
}
