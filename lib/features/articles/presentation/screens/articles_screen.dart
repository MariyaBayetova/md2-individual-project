import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/state_widgets.dart';
import '../providers/article_providers.dart';
import '../widgets/article_card.dart';

class ArticlesScreen extends ConsumerWidget {
  const ArticlesScreen({super.key});

  static const _categories = ['All', 'Covid-19', 'Diet', 'Fitness'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(articleCategoryProvider);
    final articles = ref.watch(displayedArticlesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Row(
              children: _categories.map((c) {
                final isSelected = c == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => ref
                        .read(articleCategoryProvider.notifier)
                        .state = c,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        c,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),

          // Popular articles label
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              category == 'All'
                  ? 'Popular Articles'
                  : '$category Articles',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),

          // Articles list
          Expanded(
            child: articles.when(
              loading: () =>
                  const ShimmerList(count: 5, itemHeight: 110),
              error: (e, _) => ErrorView(
                message: 'Could not load articles.\n$e',
                onRetry: () =>
                    ref.invalidate(articlesProvider(category)),
              ),
              data: (list) => list.isEmpty
                  ? const EmptyView(
                      message: 'No articles in this category.',
                      icon: Icons.article_outlined,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: list.length,
                      itemBuilder: (context, index) =>
                          ArticleCard(article: list[index]),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
