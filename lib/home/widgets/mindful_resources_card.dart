import 'package:final_project/article/article_detail_page.dart';
import 'package:final_project/article/article_service.dart';
import 'package:flutter/material.dart';

class MindfulResourcesCard extends StatelessWidget {
  final Article article;
  final VoidCallback? onPressed;

  const MindfulResourcesCard({
    super.key,
    required this.article,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: GestureDetector(
        onTap:
            onPressed ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArticleDetailPage(article: article),
                ),
              );
            },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: Image.asset('assets/avatar.png').image,
                  radius: 24,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF926247).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Mental Health',
                    style: TextStyle(
                      color: Color(0xFF926247),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF4F3422),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Image.asset('icons/seeing.png', width: 16, height: 16),
                    const SizedBox(width: 4),
                    Text(
                      '5.241',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.favorite,
                      color: Color(0xFFED7E1C),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '318',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.comment_rounded,
                      color: const Color(0xFF4F3422).withOpacity(0.4),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '22',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
