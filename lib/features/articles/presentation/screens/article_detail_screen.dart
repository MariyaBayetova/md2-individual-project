import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/article_entity.dart';

class ArticleDetailScreen extends StatelessWidget {
  final ArticleEntity article;
  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    article.imageTag,
                    style: const TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category + read time
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          article.category,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.access_time_outlined,
                          size: 14, color: AppColors.neutral400),
                      const SizedBox(width: 4),
                      Text(
                        article.readTime,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.neutral400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Full article body — expanded from summary
                  Text(
                    article.summary,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.neutral600,
                          height: 1.7,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Understanding this topic is crucial for maintaining '
                    'good health. Medical professionals recommend staying '
                    'informed and consulting your doctor before making any '
                    'significant changes to your health routine. Always '
                    'rely on evidence-based information from trusted sources.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.neutral600,
                          height: 1.7,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Key Takeaways',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  ...[
                    'Consult your doctor for personalised advice.',
                    'Stay consistent with healthy habits over time.',
                    'Monitor your progress and adjust accordingly.',
                    'Prevention is always better than treatment.',
                  ].map(
                    (point) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle_outline,
                              size: 16, color: AppColors.primary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              point,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.neutral600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
