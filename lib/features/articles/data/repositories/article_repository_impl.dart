import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/article_repository.dart';
import '../models/article_model.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<ArticleEntity>> getArticles({String? category}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final all = ArticleModel.getMockArticles();
    if (category == null || category == 'All') return all;
    return all.where((a) => a.category == category).toList();
  }
}
