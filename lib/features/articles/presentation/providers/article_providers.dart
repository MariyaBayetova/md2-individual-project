import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/usecases/get_articles_usecase.dart';

final articleCategoryProvider = StateProvider<String>((ref) => 'All');

final articlesProvider =
    FutureProvider.family<List<ArticleEntity>, String>((ref, category) async {
  return sl<GetArticlesUseCase>().call(
    category: category == 'All' ? null : category,
  );
});

final displayedArticlesProvider =
    Provider<AsyncValue<List<ArticleEntity>>>((ref) {
  final category = ref.watch(articleCategoryProvider);
  return ref.watch(articlesProvider(category));
});
