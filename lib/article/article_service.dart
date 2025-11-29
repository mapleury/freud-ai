// article.dart
class Article {
  final String title;
  final String image;
  final String content;

  Article({
    required this.title,
    required this.image,
    required this.content,
  });
}

class ArticleService {
  // Static list of sample articles — immediately initialized, no late, no errors
  static final List<Article> sampleArticles = [
    Article(
      title: "Understanding Your Mental Space",
      image: "https://picsum.photos/400",
      content:
          "Your mental space is like a garden. Whatever you water will grow. Being aware of your thoughts is the first step to gaining clarity. "
          "Notice what occupies your mind during the day—are they constructive, calming, or repetitive worries? "
          "Try to consciously direct attention to thoughts that nourish your growth and gently let go of those that don’t. "
          "Journaling, meditation, or even quiet reflection can help you identify patterns and give you the tools to cultivate a healthier, more peaceful inner world. "
          "Remember, clarity is not about suppressing thoughts but understanding and organizing them.",
    ),
    Article(
      title: "How to Deal With Overthinking",
      image: "https://picsum.photos/401",
      content:
          "Overthinking can drain your emotional and mental energy faster than you realize. It often disguises itself as problem-solving but ends up trapping you in loops of doubt. "
          "One strategy is to give your mind a scheduled ‘worry time’—a dedicated period where you allow yourself to process concerns and brainstorm solutions. "
          "Outside that window, gently redirect your attention to the present moment. Mindfulness exercises, such as deep breathing or grounding techniques, can help break the cycle. "
          "Also, writing down your worries can externalize them, giving you perspective and reducing their intensity. "
          "Overthinking is natural, but it doesn’t have to control your day.",
    ),
    Article(
      title: "Why Resting Doesn’t Make You Weak",
      image: "https://picsum.photos/402",
      content:
          "Rest is often undervalued in a world that glorifies constant productivity. Yet, mental and physical rest are essential for resilience and creativity. "
          "When you rest, your brain processes experiences, consolidates memories, and restores energy. It’s a fundamental part of human functioning—not a luxury. "
          "Allow yourself moments of stillness, whether it’s a short nap, a walk in nature, or a quiet cup of tea. Notice how your mind feels afterward—often clearer, calmer, and more capable. "
          "Rest is maintenance, not weakness. By respecting your need for downtime, you’re actually building a stronger foundation for everything you aim to achieve.",
    ),
  ];

  // Optional: simulate async fetch
  Future<List<Article>> getArticles() async {
    await Future.delayed(Duration(milliseconds: 500));
    return sampleArticles;
  }
}
