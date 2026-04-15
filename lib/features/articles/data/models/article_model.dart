import '../../domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.category,
    required super.readTime,
    required super.imageTag,
  });

  static List<ArticleModel> getMockArticles() => [
        const ArticleModel(
          id: 'a1',
          title: 'The 25 Healthiest Fruits You Can Eat',
          summary:
              'Fruits are packed with vitamins, fiber, and antioxidants. '
              'From berries to citrus, discover which fruits deliver the '
              'most nutritional benefits and how to include them in your diet.',
          category: 'Diet',
          readTime: '5 min',
          imageTag: '🍎',
        ),
        const ArticleModel(
          id: 'a2',
          title: 'The Second Wave of COVID-19: What You Need to Know',
          summary:
              'Health experts explain what to expect as infection rates '
              'fluctuate globally and how vaccines continue to protect '
              'against severe illness and hospitalisation.',
          category: 'Covid-19',
          readTime: '7 min',
          imageTag: '🦠',
        ),
        const ArticleModel(
          id: 'a3',
          title: '10 Fitness Habits That Actually Stick',
          summary:
              'Building a lasting fitness routine is less about willpower '
              'and more about smart habit design. These science-backed '
              'strategies help you stay consistent without burning out.',
          category: 'Fitness',
          readTime: '4 min',
          imageTag: '💪',
        ),
        const ArticleModel(
          id: 'a4',
          title: 'Traditional Herbal Medicine Treatments for COVID-19',
          summary:
              'Researchers are studying traditional plant-based remedies '
              'alongside conventional treatments. Here\'s what the evidence '
              'says about herbal medicine and immune support.',
          category: 'Covid-19',
          readTime: '6 min',
          imageTag: '🌿',
        ),
        const ArticleModel(
          id: 'a5',
          title: 'Beauty Tips for Skin: 10 Dos and Don\'ts',
          summary:
              'Healthy skin starts with the right habits. Dermatologists '
              'share the most common skincare mistakes people make and '
              'how simple changes can transform your complexion.',
          category: 'Fitness',
          readTime: '3 min',
          imageTag: '✨',
        ),
        const ArticleModel(
          id: 'a6',
          title: 'How Sleep Affects Your Heart Health',
          summary:
              'Cardiologists explain the direct link between quality sleep '
              'and cardiovascular health. Poor sleep patterns are linked '
              'to higher risk of hypertension and heart disease.',
          category: 'Diet',
          readTime: '5 min',
          imageTag: '❤️',
        ),
        const ArticleModel(
          id: 'a7',
          title: 'Understanding Your Blood Sugar Levels',
          summary:
              'Managing blood glucose is key for both diabetics and '
              'non-diabetics. Learn what normal ranges look like, what '
              'affects them, and when to see a doctor.',
          category: 'Diet',
          readTime: '6 min',
          imageTag: '🩸',
        ),
        const ArticleModel(
          id: 'a8',
          title: 'Best Exercises for Lower Back Pain',
          summary:
              'Lower back pain affects millions worldwide. Physical '
              'therapists recommend these targeted stretches and '
              'strengthening exercises to relieve and prevent pain.',
          category: 'Fitness',
          readTime: '4 min',
          imageTag: '🧘',
        ),
        const ArticleModel(
          id: 'a9',
          title: 'COVID-19 Vaccines: Myths vs Facts',
          summary:
              'Misinformation about vaccines continues to spread online. '
              'Medical professionals address the most common myths and '
              'explain what the science actually shows.',
          category: 'Covid-19',
          readTime: '8 min',
          imageTag: '💉',
        ),
        const ArticleModel(
          id: 'a10',
          title: 'The Mediterranean Diet: A Complete Guide',
          summary:
              'Consistently ranked the world\'s healthiest diet, the '
              'Mediterranean approach emphasises whole foods, healthy fats, '
              'and regular physical activity for long-term wellbeing.',
          category: 'Diet',
          readTime: '7 min',
          imageTag: '🥗',
        ),
      ];
}
